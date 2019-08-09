Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA656C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A966E204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436844AbfHIPu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:50:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:58334 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436700AbfHIPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:50:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="175189700"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2019 08:50:51 -0700
Date:   Fri, 9 Aug 2019 18:50:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca,
        tyhicks@canonical.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive
 or deactivated
Message-ID: <20190809155050.5n7dbmabysdlra4m@linux.intel.com>
References: <20190805164427.17408-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805164427.17408-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 06:44:27PM +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
> TPM") allows the trusted module to be loaded even if a TPM is not found, to
> avoid module dependency problems.
> 
> However, trusted module initialization can still fail if the TPM is
> inactive or deactivated. tpm_get_random() returns an error.
> 
> This patch removes the call to tpm_get_random() and instead extends the PCR
> specified by the user with zeros. The security of this alternative is
> equivalent to the previous one, as either option prevents with a PCR update
> unsealing and misuse of sealed data by a user space process.
> 
> Even if a PCR is extended with zeros, instead of random data, it is still
> computationally infeasible to find a value as input for a new PCR extend
> operation, to obtain again the PCR value that would allow unsealing.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

OK so this has been now applied. I'm going to do a PR over
the weekend, which means that the fix will land to 5.3.

/Jarkko
