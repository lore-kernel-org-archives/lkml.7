Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0E3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77272186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OFE56oXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfH3FDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:03:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfH3FDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:03:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so2903093pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=l/SRc+T1+zG8Df0Y2qbqNAsBTtdjYH2T4Q4ixAT4EFU=;
        b=OFE56oXW+++O90cUO7iBwxo6K51w+Om1VsIaoaHHQzpKaHBWZSLC+rswzE/DZVQi9R
         5iAuTGDv3jBkFheNGCta6YauJ0qHNTP4Gr1MnVYiVBBeWvwd0p/QO9Aw4bWGHhN4fsml
         buetKU86nGkMZHK3VJQGLHSdJjpInmuogEc20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=l/SRc+T1+zG8Df0Y2qbqNAsBTtdjYH2T4Q4ixAT4EFU=;
        b=gFPdKHUePX8qKYVrYIEVNHO6nelS1ZWMoV1FyaMBgJQ6sJPbAWeUNx6BrsPIS6zuv1
         GO/bRhiCU9eCoXqy3MdSsxMN7A1lWOrqIdsfpUUWst0jmCGXbdCfQS5N+aeq29qn3Mdh
         25pGQ3t31vLA9Wt81FJCs22R/OTRwtKoU+yKAQMxQQ6f9alJH3JIvi08lvkvq8duzyhR
         WWRhARqkaDoeuizd0lJyLDtcdUZ/LolmcGjmlBVvfKX/v8kRKQWZ/wDKUZRS+3yJkpzM
         RMfbM1w2Gj11cqnc5mPKS00U5KTb78j854egk4QHQ5OumXHpnVhfnJ4MDViN80L9rjcU
         Yg/A==
X-Gm-Message-State: APjAAAXUoJ/iTd7hyqOU+SkrwBlYLKgegLdJQP/gCIhMhhm7mvfi2Qgm
        neTTy2nzSCc5QVCfjx8hgfledQ==
X-Google-Smtp-Source: APXvYqwqwBeN7KOSBghQiwN4xU+AiQkM1MRwhVSZNyPb3TA+PAAnyHv0/vecV7H7NX6Irh9G/XdLvg==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr15256774pff.37.1567141424316;
        Thu, 29 Aug 2019 22:03:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m16sm1512892pff.140.2019.08.29.22.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:03:43 -0700 (PDT)
Message-ID: <5d68ae2f.1c69fb81.bc783.5e84@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830022402.214442-1-hungte@chromium.org>
References: <5d67e673.1c69fb81.5f13b.62ee@mx.google.com> <20190830022402.214442-1-hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] firmware: google: check if size is valid when decoding VPD data
To:     Hung-Te Lin <hungte@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 22:03:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hung-Te Lin (2019-08-29 19:23:58)
> The VPD implementation from Chromium Vital Product Data project used to
> parse data from untrusted input without checking if the meta data is
> invalid or corrupted. For example, the size from decoded content may
> be negative value, or larger than whole input buffer. Such invalid data
> may cause buffer overflow.
>=20
> To fix that, the size parameters passed to vpd_decode functions should
> be changed to unsigned integer (u32) type, and the parsing of entry
> header should be refactored so every size field is correctly verified
> before starting to decode.
>=20
> Fixes: ad2ac9d5c5e0 ("firmware: Google VPD: import lib_vpd source files")
> Signed-off-by: Hung-Te Lin <hungte@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

