Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA8122CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfH1R5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47789 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfH1R5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8355315C01C;
        Wed, 28 Aug 2019 17:57:03 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D8955C21E;
        Wed, 28 Aug 2019 17:57:03 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
References: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156686729996.184120.3458026302402493937.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 28 Aug 2019 13:57:02 -0400
In-Reply-To: <156686729996.184120.3458026302402493937.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Mon, 26 Aug 2019 17:55:00 -0700")
Message-ID: <x497e6x8975.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 28 Aug 2019 17:57:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> An attempt to freeze DIMMs currently runs afoul of default blocking of
> all security operations in the entry to the 'store' routine for the
> 'security' sysfs attribute.
>
> The blanket blocking of all security operations while the DIMM is in
> active use in a region is too restrictive. The only security operations
> that need to be aware of the ->busy state are those that mutate the
> state of data, i.e. erase and overwrite.
>
> Refactor the ->busy checks to be applied at the entry common entry point
> in __security_store() rather than each of the helper routines to enable
> freeze to be run regardless of busy state.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/nvdimm/dimm_devs.c |   33 ++++++++++++++++-----------------
>  drivers/nvdimm/security.c  |   10 ----------
>  2 files changed, 16 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 53330625fe07..d837cb9be83d 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -424,9 +424,6 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
>  	unsigned int key, newkey;
>  	int i;
>  
> -	if (atomic_read(&nvdimm->busy))
> -		return -EBUSY;
> -
>  	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
>  			" %"__stringify(KEY_ID_SIZE)"s"
>  			" %"__stringify(KEY_ID_SIZE)"s",
> @@ -451,23 +448,25 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
>  	} else if (i == OP_DISABLE) {
>  		dev_dbg(dev, "disable %u\n", key);
>  		rc = nvdimm_security_disable(nvdimm, key);
> -	} else if (i == OP_UPDATE) {
> -		dev_dbg(dev, "update %u %u\n", key, newkey);
> -		rc = nvdimm_security_update(nvdimm, key, newkey, NVDIMM_USER);
> -	} else if (i == OP_ERASE) {
> -		dev_dbg(dev, "erase %u\n", key);
> -		rc = nvdimm_security_erase(nvdimm, key, NVDIMM_USER);
> +	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
> +		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
> +		rc = nvdimm_security_update(nvdimm, key, newkey, i == OP_UPDATE
> +				? NVDIMM_USER : NVDIMM_MASTER);
> +	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
> +		dev_dbg(dev, "%s %u\n", ops[i].name, key);
> +		if (atomic_read(&nvdimm->busy)) {
> +			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
> +			return -EBUSY;
> +		}
> +		rc = nvdimm_security_erase(nvdimm, key, i == OP_ERASE
> +				? NVDIMM_USER : NVDIMM_MASTER);
>  	} else if (i == OP_OVERWRITE) {
>  		dev_dbg(dev, "overwrite %u\n", key);
> +		if (atomic_read(&nvdimm->busy)) {
> +			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
> +			return -EBUSY;
> +		}
>  		rc = nvdimm_security_overwrite(nvdimm, key);
> -	} else if (i == OP_MASTER_UPDATE) {
> -		dev_dbg(dev, "master_update %u %u\n", key, newkey);
> -		rc = nvdimm_security_update(nvdimm, key, newkey,
> -				NVDIMM_MASTER);
> -	} else if (i == OP_MASTER_ERASE) {
> -		dev_dbg(dev, "master_erase %u\n", key);
> -		rc = nvdimm_security_erase(nvdimm, key,
> -				NVDIMM_MASTER);
>  	} else
>  		return -EINVAL;
>  
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 5862d0eee9db..2166e627383a 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -334,11 +334,6 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
>  			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
> -	if (atomic_read(&nvdimm->busy)) {
> -		dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
> -		return -EBUSY;
> -	}
> -
>  	rc = check_security_state(nvdimm);
>  	if (rc)
>  		return rc;
> @@ -380,11 +375,6 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  			|| !nvdimm->sec.flags)
>  		return -EOPNOTSUPP;
>  
> -	if (atomic_read(&nvdimm->busy)) {
> -		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
> -		return -EBUSY;
> -	}
> -
>  	if (dev->driver == NULL) {
>  		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
>  		return -EINVAL;
>
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
