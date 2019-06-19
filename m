Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF97C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD112189E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bkynCYDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfFSPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:06:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46314 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfFSPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so12371463lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bi/NrYG+8sOnuxk9q70QkcnFR1MkzWvqPkJLzNB9EUY=;
        b=bkynCYDZirwIrahFMCwUlYTHjTAyuCDr5SeJY6dLXr4s5kETTWeNYIkUC2JCIHgjXd
         hTR18j+Vq+TjLDHN7RAjmoT95KMKsHGv/g8kEKouOuVTPWFCu2xAf4r+t5rcB6V60pV1
         q8YKqP98KHr/LFnX5XuAHmo8AIWk2hjZ0vo2H9c8Ai9BGHZu9beLZ/GVBo+fHz0BLe+O
         Jii8meli6T2ciJV+5hhEQywiCj6ngKyAP4ojML+sNjaeH/Sd63oTvcuprq+L/RcsHJ7p
         70p07j37cX2UdHPgjgt9NhpdOZ1CD58Npafqa0WiNQJLstZDbDpo+GJRtm4W5R6hd2KS
         o6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bi/NrYG+8sOnuxk9q70QkcnFR1MkzWvqPkJLzNB9EUY=;
        b=dd7+vKBqy2Gd/Gm/3NwdhxleTl7brUAmHJcyCXwiTjy88F4Qk3g5Wd0a8HCXyxx3Pc
         75VAgtky5Vhihx/OlZsupmCGzWMufH7KAH4i6zoZte9eVzScxpOc7lTSBwtGtsu0GGZ+
         hCjMV/y98f5kpu9IGvNUyN/AtzZeig2UwcIeuUVfU1eRUrisMwRExwPamydsDCJceXVB
         EL3VOYICJON3UsX/obfQCgeC3GZVrwixv+NT0W9vKc4S/3IIEh5aebqw7rhdExs5Rmny
         EXMHhn7+dlBf6D7h/k+ZR+2bCg4/DJd0YEQh/7OBha2JQ70pjH4u/Pz/aKed+zC++RwJ
         NOQQ==
X-Gm-Message-State: APjAAAUYOrhRB1RtHlktACFoGeqMoD7+txWqW8i7pJvpvo0ollUyc9s2
        mFlaSohsJb9tMwrYkwTy71FNEg==
X-Google-Smtp-Source: APXvYqyiBsf9vdQVTu7mhmXMLSLNX4OELuXE3oFCKOSyKLuJ/4ZLE4f8StUo2YggWubm0wcbIy7+TQ==
X-Received: by 2002:ac2:5981:: with SMTP id w1mr41997022lfn.48.1560956768945;
        Wed, 19 Jun 2019 08:06:08 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f16sm3047807lfc.81.2019.06.19.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:06:06 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:18:22 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: enable Lima driver
Message-ID: <20190619141822.vwcfyhatlsa5x4cn@localhost>
References: <20190606085645.31642-1-narmstrong@baylibre.com>
 <20190606085645.31642-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606085645.31642-2-narmstrong@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:56:45AM +0200, Neil Armstrong wrote:
> A bunch of armv7 boards can now use the Lima driver, let's enable it
> in defconfig, it will be useful to have it enabled for KernelCI
> boot and runtime testing.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!


-Olof
