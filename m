Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B193C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 05:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B76C207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 05:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kryr+rf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfLDFCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 00:02:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDFCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 00:02:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so2746766pgl.5;
        Tue, 03 Dec 2019 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=sh0rhxSSYeCV5jiM2XJT9S/DaC1LWbE6pmb5LwSXCaQ=;
        b=Kryr+rf1qV5LX3RuTXTEOjQgv/nr54R+aZmlr2nhZiCquGc7/maVzVOUY9UYIKPHiU
         v9lBptLU0VC/WTwvK16mGFgoEw5mgUKPpXrXnvfKfN2iB3UU9FQRhcteZLDRGWWcIFOo
         81zK/OAaFLhMCS6cCR8QeRDFYVmjTPOlIRG5nLvOe4OgurjM9j2L9m48cfVtOwOhZ0jZ
         3opC7yg6diLGd12MhLTxyXHKwvpLcBYp3wMUGlnhwzbD/qbLfyKS+w+9Y75c2+9oGRTt
         eGDRFzYJE+xq0KBNoh7hA9KVIdZZ3iELRP6TCyE6Jylbdp+7Z4SstiFqNTm1lKKSVYlV
         +5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=sh0rhxSSYeCV5jiM2XJT9S/DaC1LWbE6pmb5LwSXCaQ=;
        b=WWdQG9eXI+m/YIJZkMf780enm2XmHrg80cx9J+1xgA0xg2OgHycTXMebdXlAtK8blC
         kWDx+ODXS+AenY//biHLTXu/dRxpMNwji0OOUO9JQI1YdnpQ3p/UzEWv0TLeJ9rzUsqe
         3lFdIDtHfSMdjNBYZxs0ci1UkLrqkd/30P9h/ibmPicLFwlE4iHQgFFMWBkgZ0XFlLPR
         DTY0jTZ5HasO1/BqLun/gS5uhfWVGuyGBJOcsVf9gmBfC9/FE5Nr2BKnZhsR/MxDcJeu
         HYU38I8dv8TNTCse4tTvAlH3TDfnGuGbSr4e6Xb3Q9X9KRiNUn+pHwcFpHfMrsASJKL7
         jKvQ==
X-Gm-Message-State: APjAAAU7PMmBx+ICX8rkbgbRny9fszKwjj9Hdi9qaylRnv5wmlsgmv7O
        J0HA2Gz+FXiF1IJYaM7dCuUvOSH1
X-Google-Smtp-Source: APXvYqwG07jRHYz4gUv0b9dR+t5+WsoZR/hbMcZcxk3Av8XdTHT4ar6E778UpNzRUbIQwJvEE+KFdw==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr1488512pgb.249.1575435754219;
        Tue, 03 Dec 2019 21:02:34 -0800 (PST)
Received: from udknight.localhost ([183.250.89.86])
        by smtp.gmail.com with ESMTPSA id m68sm5958309pfm.85.2019.12.03.21.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 21:02:33 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id xB44u1FP010546;
        Wed, 4 Dec 2019 12:56:01 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id xB44txmU010545;
        Wed, 4 Dec 2019 12:55:59 +0800
Date:   Wed, 4 Dec 2019 12:55:59 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     afaerber@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
Subject: perf record doesn't work on rtd129x SoC
Message-ID: <20191204045559.GA10458@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, afaerber@suse.de,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas Färber!

I use "perf record" to debug performance issue on RTD1296 SOC, it does't work, but
the "perf stat" is ok!

After some dig in the kernel, I find the reason is no pmu overflow interrupt, I think
below pmu configuration isn't right for RTD1296:
"
        arm_pmu: arm-pmu {
                compatible = "arm,cortex-a53-pmu";
                interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
        };
"

We need 4 PMU SPI for RTD1296 (4 cores), and I guess the 48 isn't right too.

Any suggestion is welcome.

Thanks!



