Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27B21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cFFKW6Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfK1Vns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:43:48 -0500
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:37297
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbfK1Vns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574977427; bh=JJX53ZDVgTgnh3OnafAf9V2Zn5t6h/TnhI0z0ZSSrJE=; h=From:Subject:Date:To:References:From:Subject; b=cFFKW6KtwqZQLc92mm0z/Pr10I/cXyjDFxdjG49h781PC0+m89VTw9/bi/7EyaA5HcPWokcJV/zVqNHHQD2fPN1E2XYJkAuKWtB73jZVDGJ6y37pB7yrxUW+PJMUIu6vbW2S+nIklovJr7lXxNDcm/XB0JuzCjGUAHefI3n5mrLIen2k5db13BqXt6ifzldgmpNkFB3Kvq3UUSFlhFhDXwNnLPnWGi/Qar7GEWnnGDn+tR/Yph46kTqHfaO6pk2cTHmaufOcSOS3uDgSzyalCZoQa3/dSUowculyvfPV9igmh5UoyG7rCP/3XplK/A2O8emjLMTzUDz32HUJwn6Clw==
X-YMail-OSG: nyen1NUVM1mtumbf5cI5zYfS5DdYJZhbS3fHrCi8b0ql4ryOG9N9MAG3Ywboxmw
 svb0eAv6XNW959VIoqebxi.rIG2nlh2m5SUGMKPqHsRMy_qUnS9G0hN5Ys41uqdZM6b0ReFxQAcn
 p2.HOlrHzGdRocyUMqk..jF0QskGL6EY4O80oPGBCZLVnG6sbVfVFi66kbMIktDkFJIc3UsUK3Rg
 y6vqPNNr86UhVOwTlbITmSSsdUiNCvkdWeAdtPLl8Kl0dtFzQ6uiE0aAJzVdACYrG2VDbTxVSfCo
 8iLE0ylTUHeWuVYd.jz4.fo43c_8YisGhryMlRGheEUJleaEuqAWqgP.XRvOH3jxYOSei2a4_qmN
 lHFPkZZOywYBrE.4X.lJ1zOQNGgvx2lDdOAwX5w5dysApOlqG.HctEnY0px2cz6nCrdAPVogMyzQ
 QtE.kAEQ8goNnNNuf2lg_g9JXCqeWfwOCE7GQKw46Fg2I_R9W0fX.TiIQpg96tWttumfoKOb45hX
 OdEWS4HI27POlIR_mCEUmJzBn.GVEQqFwDMJZGg7bBF00jzou5qg37RBBYkR9ZWaATOFlBa8CMYM
 4IWPxaOtjDP5SBSzahwMmreKht2wk9RF3kGriD.bJvmCSZ3H3C.gpcj526RoexeMv6XXlwm9ITlI
 NoxSFwVIYM400qzZQYxKSuAD5yts8t6BinKIRvR8EBEx.DQj95a_RVE4lCwRmbIT2Co4KUrqETPM
 .vrlZ5fAC.BetxUQWYo.TIJe8Kk7narwfxQVVqLiEXBTPcRvO6ORxnac8IfPf8WH2O8C6MANBJTQ
 wgbnfXHAKkDiBS3UhqSeDNk8pD4JujG46Uhqx9efU3NNVBY2pt0fjs22p1J9ua3G4mfZ9YyDe.TE
 G387HH_CNF29LPz0ZdL9.LM4bOc92mwcuwXWkE0tIDYuavR6LmWMkmjqYyoZ8gQYHmHQNdv9Eq5X
 jloIzJH56xwKU1I8gyG6u531_iEvzE82mTsjyqQyzXmKwERLHRxt4IO6JPJu00wyxw6VbJJLV9gZ
 AvzwUA0D0eO5H_ZCbq6E11QmIyQIFePyiJYav_zQtisRDfG_glwryAoT6F_Irsuo6B059uIIeZiY
 chEh9iSLxyUuFboZ_wFYK92l4vO3iXfL02zOPxz8ZEfzHWGO.py6y9n5G0y__siLuSFkNC5SQoVx
 e8y0pLeu3.jVaIIKfNZXhsIJ7joQQFzgpaA7xM9mufiYgSvtT2fAH1eYv2oXuQCYgMnZM_KGWcLt
 VaOhue3IwegaDvPtfIsWLAuUwzjAPJxduCnLt5_A71HuPGtyAooCGcGE.9kNbNgKO6_xtHcw_79q
 BbJIEjXedTNJuH_i344Nm6v.GDzx7YM3Vmak3fdkVKT_779v5fFP.Xi_OQ_eaZEc1t1lgwCJNin.
 XGp_MVeZnm.cbFOYUDS92yBSXeQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Nov 2019 21:43:47 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 65a850a23e72b4d8af12bb5f0e296bc3;
          Thu, 28 Nov 2019 21:43:45 +0000 (UTC)
From:   "admin ." <admin@0x55-0x4e-0x49-0x45-0x46.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: You can use c++ to compile the linux kernel!!
Message-Id: <55D04AA9-FA9B-4EFE-A469-1940FCBC94B4@0x55-0x4e-0x49-0x45-0x46.com>
Date:   Thu, 28 Nov 2019 13:43:36 -0800
To:     LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
References: <55D04AA9-FA9B-4EFE-A469-1940FCBC94B4.ref@0x55-0x4e-0x49-0x45-0x46.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just symlink c++ to cc, it works partially on my computer

That means classes, smart pointers, all that junk

Right?

Unidef 
