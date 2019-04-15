Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8CDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008B1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDOMEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfDOMEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B0F0308A953;
        Mon, 15 Apr 2019 12:04:07 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91BF060142;
        Mon, 15 Apr 2019 12:04:06 +0000 (UTC)
Subject: Re: [PATCH] modules: Only return -EEXIST for modules that have
 finished loading
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cavery@redhat.com
References: <20190402133916.13513-1-prarit@redhat.com>
 <20190415112313.GA4080@linux-8ccs>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <2c27c9cf-0ce3-1c7f-bdc2-760d6d37d4d1@redhat.com>
Date:   Mon, 15 Apr 2019 08:04:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190415112313.GA4080@linux-8ccs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 15 Apr 2019 12:04:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 7:23 AM, Jessica Yu wrote:
> +++ Prarit Bhargava [02/04/19 09:39 -0400]:
>> Microsoft HyperV disables the X86_FEATURE_SMCA bit on AMD systems, and
>> linux guests boot with repeated errors:
>>
>> amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>> amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>> amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>> amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>> amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>> amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>>
>> The warnings occur because the module code erroneously returns -EEXIST
>> for modules that have failed to load and are in the process of being
>> removed from the module list.
>>
>> module amd64_edac_mod has a dependency on module edac_mce_amd.  Using
>> modules.dep, systemd will load edac_mce_amd for every request of
>> amd64_edac_mod.  When the edac_mce_amd module loads, the module has
>> state MODULE_STATE_UNFORMED and once the module load fails and the state
>> becomes MODULE_STATE_GOING.  Another request for edac_mce_amd module
>> executes and add_unformed_module() will erroneously return -EEXIST even
>> though the previous instance of edac_mce_amd has MODULE_STATE_GOING.
>> Upon receiving -EEXIST, systemd attempts to load amd64_edac_mod, which
>> fails because of unknown symbols from edac_mce_amd.
>>
>> add_unformed_module() must wait to return for any case other than
>> MODULE_STATE_LIVE to prevent a race between multiple loads of
>> dependent modules.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Reported-by: Cathy Avery <cavery@redhat.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
> 
> Applied to modules-next. Thanks Prarit!

Jessica, could I have the URL of the git tree?

Thanks,

P.

> 
> Jessica
> 
