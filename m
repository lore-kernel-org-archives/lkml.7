Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C40C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A24214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4jgwY+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfGaT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:58:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46005 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfGaT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:58:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so30964650plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NfIspcnc/2t7LWXrdNE+ubsJCC83+V9yAq4B7B5lNHE=;
        b=Q4jgwY+JqY8cWP5Ba3AUxsKHoDBJfSroGhiXbMR6OrTJimuIBMapLxpymuNCBbRYxm
         ncoDEJL5taLB4w3SrlTtacnLIUIGo18Ay/EoIuMP3Iq+TOLJs1WFQHKC2FYJFAYTKqjY
         XJ9EHmGJnbi6QNDD4KlOHD+Wnl3OqbAoM7DXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NfIspcnc/2t7LWXrdNE+ubsJCC83+V9yAq4B7B5lNHE=;
        b=SvUV1vR31Slu4NSLYoGDdFPZB9flvorAm+5mQK45+SmlKyZ+SYgm/RSHJ/NvVrg9iz
         uiTmaLK+5TCLCzXuvtyGKc0JQSxiHtEfeObTXoEnn/LgJnB+PD816zUr4QyuzbjoeWVH
         klBEyJ0ZZkxvqUwKN0Sa1oiL8laIoDFhi2yp65vpCDzEZcPVs4yU7rEhgb5F+BXwvN38
         ft2AEqDVR0oGJuRL66AECLGU2ov0D9x8YaYEtP0rN4tFfgQ4F1iKESSfROtkDA0Wj/TS
         zeusNh++JEn9ayUDbYBDKz8lJr0WROK2ZOkxdm1DYU1eiA202Cj8Zye8AQv73dDlSbFN
         jfEg==
X-Gm-Message-State: APjAAAVF4uTBDIEMV+CgKVM7SLYHcL/2c/V9CJ32Dr3lbYVlucGF1LcV
        HbktdbykyEZDPpgciUjjjNhD0LOrgYk=
X-Google-Smtp-Source: APXvYqw+WHzdDfbYGy29+WSP8iMiYjFhVylC6I4hxMOf3DMb3RNqGFamdATEt9zqoJx2J75sr60bUA==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr123929051pln.279.1564603088343;
        Wed, 31 Jul 2019 12:58:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm2495362pjk.13.2019.07.31.12.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 12:58:07 -0700 (PDT)
Date:   Wed, 31 Jul 2019 12:58:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joonwon Kang <kjw1627@gmail.com>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        jinb.park7@gmail.com
Subject: Re: [PATCH 1/2] randstruct: fix a bug in is_pure_ops_struct()
Message-ID: <201907311257.8436E997A4@keescook>
References: <cover.1564595346.git.kjw1627@gmail.com>
 <2ba5ebfa2c622ece4952b5068b4154213794e5c4.1564595346.git.kjw1627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba5ebfa2c622ece4952b5068b4154213794e5c4.1564595346.git.kjw1627@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:01:10AM +0900, Joonwon Kang wrote:
> Before this, there were false negatives in the case where a struct
> contains other structs which contain only function pointers because
> of unreachable code in is_pure_ops_struct().
> 
> Signed-off-by: Joonwon Kang <kjw1627@gmail.com>

I've applied this (with some commit log tweaks) and it should be visible
in linux-next soon. I'll send this on to Linus before -rc3.

-- 
Kees Cook
