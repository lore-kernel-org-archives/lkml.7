Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F7DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFAE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJJOal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:30:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:19153 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfJJOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:30:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 07:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="345721636"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2019 07:30:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iIZSg-0003Ao-Fl; Thu, 10 Oct 2019 22:30:38 +0800
Date:   Thu, 10 Oct 2019 22:29:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/inside-secure/safexcel_cipher.c:2001:1-3: WARNING:
 PTR_ERR_OR_ZERO can be used
Message-ID: <201910102236.4K1XBa2F%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a8c600de5dc1d9a7f4b83269fddc80ebd3dd045
commit: 3e450886ec573cb9d7cb1758317b5e4e0f308b52 crypto: inside-secure - Added support for basic AES-GCM
date:   5 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/crypto/inside-secure/safexcel_cipher.c:2001:1-3: WARNING: PTR_ERR_OR_ZERO can be used

vim +2001 drivers/crypto/inside-secure/safexcel_cipher.c

  1989	
  1990	static int safexcel_aead_gcm_cra_init(struct crypto_tfm *tfm)
  1991	{
  1992		struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
  1993	
  1994		safexcel_aead_cra_init(tfm);
  1995		ctx->hash_alg = CONTEXT_CONTROL_CRYPTO_ALG_GHASH;
  1996		ctx->state_sz = GHASH_BLOCK_SIZE;
  1997		ctx->xcm = 1; /* GCM */
  1998		ctx->mode = CONTEXT_CONTROL_CRYPTO_MODE_XCM; /* override default */
  1999	
  2000		ctx->hkaes = crypto_alloc_cipher("aes", 0, 0);
> 2001		if (IS_ERR(ctx->hkaes))
  2002			return PTR_ERR(ctx->hkaes);
  2003	
  2004		return 0;
  2005	}
  2006	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
