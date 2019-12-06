Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6AEC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A632467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="giJuCIV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLFVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:20:38 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:36059 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLFVUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Txo2WUEcc/xwK47u8ogNCI+IkeDC/BmS0irmdN8p5x8=; b=giJuCIV4If/vjNRHI7C6XPPftj
        iZQFrpB6Qwkys+zsH2Yy28nBbfaGwRqDQe9a6yqlz9QcJV0Ri8G25XzPQkRYFZSWv5DIhnv77CTrl
        x1yY9iUzXaJU92sWqRzLWu+mzKfe38BhEfe3I853Eobbou/uVCHOgyCm4l5EjijyhzGSwOJuVwD1U
        cPK/N+Z1mrWoYiy7NKvGlh9kS5v/pQ/wvp1Z/M9Vnixvad+Nw7S8gCOVcQhZ5Tg7GI6+M3EtxK04c
        xqpPJ2CzqC7hs72LN00t1biiwiYr7lmysEmXcRJDGR8uZzOgfnI/sOmbfU2d/jKI/Ze6/JDh0KgkA
        EXqgYUwQ==;
Received: from 91-154-92-5.elisa-laajakaista.fi ([91.154.92.5] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@linux.intel.com>)
        id 1idL1b-0002lX-IP; Fri, 06 Dec 2019 23:20:31 +0200
Date:   Fri, 6 Dec 2019 23:20:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Zhao, Shirley" <shirley.zhao@intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-ID: <20191206212031.GE9971@linux.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
 <1573659978.17949.83.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574796456.4793.248.camel@linux.ibm.com>
 <20191129230146.GB15726@linux.intel.com>
 <A888B25CD99C1141B7C254171A953E8E4909CA4B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E4909CA4B@shsmsx102.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 91.154.92.5
X-SA-Exim-Mail-From: jarkko.sakkinen@linux.intel.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 01:45:30AM +0000, Zhao, Shirley wrote:
> Hi, Jarkko, 
> 
> The rc1 you mentioned is the version for what? 
> How to download it and update it? 
> 
> Thanks. 

It will be available from kernel.org eventually.

/Jarkko
