Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D30C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA7A2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyx95PK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfFNQvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:51:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:51:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so3270604wrs.3;
        Fri, 14 Jun 2019 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3tjYBStu1LjnzhWqBptYBriF+bgQ9rTx2Bw7QcMOvJA=;
        b=Oyx95PK4KOIjIb7OOTGl9gw2WKLfs7prx2Mt9Qc3ZsXrXp88Smjidi11p3+a2eP3s5
         mmMXcBgnYcToGArp16I1K6Q3Ern9XTx3lngsnyA24FDdbBmPyNgcJCFHStNYncF8j0hp
         5ZMYtPY1eBZVVbPPlqLiihYOcPiHmS82z5wrcNUaZHv47z5ViZekPbX/fmBId7cw59yp
         PLzLgKOJsUuN19TtXDGdCM0ha9or7pgXE1nyvXsPQkqlzfAklUVIhqgrAd0EgocJ2bbl
         24scSrqUMzrRCXhhH1FAJ5i3CM7bK1Fy43l8dgPedauDGM3l/utGxM9kRejbs/kUzayA
         uD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3tjYBStu1LjnzhWqBptYBriF+bgQ9rTx2Bw7QcMOvJA=;
        b=PtbvUxyKJw2wd0PMUy5k8dkCz8umf+tQfu2Fq0zYwrDL7LBNeyQ/CeI6H8wV9dsu5/
         90c10PUauGvHAa41+kxNwfmvf+HUqCJi5R+EGBEC7RaQmyZrhKlkIzxsAjzxyDxGhCHl
         ECpZm+vdA/WOhgZmLs643JjdWrXBaBSo54FGkBicEd89oF1d4CleSeyl86DT92NKP4tC
         Abqi/dl96zUnI8tdOiIFPnJjdcrYEPmCXnJGhdKySqie1dRbI5MlKdJapORqK/xJ+bHW
         fcuA6T5HooyH1pi02LLsUBA3LXbcRS/rz3tRZXc05zlTx1usrVH9LkpDkrU0/kHN2QNZ
         Xt6A==
X-Gm-Message-State: APjAAAVheasnVtYVFoSkvljK37TUPrwkBuFFeqSaknG3HWi5HBp4TcYG
        hGgYYhmduJAgn3fu1g+tlEa2qw3b6aQ=
X-Google-Smtp-Source: APXvYqytYV+jti5VJHYHLE4IWpeLMPvSQ7veUqlqTSu08+uhs45aFwoeLRGR8rSwd20t6tPCErqesQ==
X-Received: by 2002:adf:e54b:: with SMTP id z11mr50141374wrm.198.1560531069659;
        Fri, 14 Jun 2019 09:51:09 -0700 (PDT)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id o8sm4627462wrj.71.2019.06.14.09.51.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:51:08 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:50:59 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7150: use ternary operating to ensure 0/1
 value
Message-ID: <20190614165059.7bifufvhxofy6ybu@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove idiom and use ternary operator for consistently trigger 0/1 value
on variable declaration.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 8234da4b8c65..25598bf124fb 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -350,8 +350,8 @@ static ssize_t ad7150_show_timeout(struct device *dev,
 
 	/* use the event code for consistency reasons */
 	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(this_attr->address);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
-			== IIO_EV_DIR_RISING);
+	int rising = (IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
+		      == IIO_EV_DIR_RISING) ? 1 : 0;
 
 	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
-- 
2.20.1

