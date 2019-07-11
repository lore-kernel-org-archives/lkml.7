Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84172C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7720863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGKTsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:48:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:42927 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfGKTsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:48:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 12:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="168116079"
Received: from mmoerth-mobl6.ger.corp.intel.com (HELO localhost) ([10.249.35.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2019 12:48:14 -0700
Date:   Thu, 11 Jul 2019 22:48:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705163735.11539-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 06:37:35PM +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even a TPM is not found to
> avoid module dependency problems.
> 
> Unfortunately, this does not completely solve the issue, as there could be
> a case where a TPM is found but is not functional (the TPM commands return
> an error). Specifically, after the tpm_chip structure is returned by
> tpm_default_chip() in init_trusted(), the execution terminates after
> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
> 
> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
> TPM_ERR_DISABLED errors.

Why allow trusted module to initialize if TPM is not functional?

Also:

err = tpm_transmit_cmd(chip, &buf,
		       offsetof(struct tpm2_get_random_out,
				buffer),
		       "attempting get random");
if (err) {
	if (err > 0)
		err = -EIO;
	goto out;
}

/Jarkko
