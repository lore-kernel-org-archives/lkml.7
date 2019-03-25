Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC52CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCFF20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfCYO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:56:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:25932 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYO4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:56:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 07:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="137265410"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.97])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2019 07:56:20 -0700
Date:   Mon, 25 Mar 2019 16:56:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, dan.j.williams@intel.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        david.safford@ge.com, jejb@linux.ibm.com,
        silviu.vlasceanu@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: defer execution of TPM-specific code
 until key instantiate
Message-ID: <20190325145619.GC29989@linux.intel.com>
References: <20190322180139.18856-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322180139.18856-1-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 07:01:39PM +0100, Roberto Sassu wrote:
> Commit 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from
> tpm_default_chip()") changed the tpm_chip argument of every TPM function
> from NULL to a pointer that is retrieved at module initialization time.
> 
> Unlike before this patch, the trusted module cannot be loaded if no TPM is
> available. Unfortunately, this causes a dependency problem because the
> encrypted key type requires the 'key_type_trusted' symbol when
> CONFIG_TRUSTED_KEYS is defined.
> 
> This patch fixes the issue by deferring the execution of TPM-specific code
> until a new trusted key is instantiated: init_tpm(), to obtain a tpm_chip
> pointer; init_digests(), introduced by commit 0b6cf6b97b7e ("tpm: pass an
> array of tpm_extend_digest structures to tpm_pcr_extend()"), to get random
> bytes from the TPM to lock a PCR.
> 
> Cc: stable@vger.kernel.org
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()")
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Definitive NAK for the release. Sorting out the dependency problem is
definitely out of scope for v5.1.

/Jarkko
