Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF9C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835821D56
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti+JWqR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfJAKLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:11:13 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:41592 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJAKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:11:13 -0400
Received: by mail-vs1-f42.google.com with SMTP id l2so8915032vsr.8;
        Tue, 01 Oct 2019 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QvJYouHy09oKF9oCn/Pwojut4WOcI15TXey54NPggiY=;
        b=Ti+JWqR9qKnaoPpThxpM7hiyIZ0v4qbbz391rXgoajSlbfBh45WFe40UMzJ7FLNl/U
         AF7wMqPdamDTfiTnTtmfFNhSaMKM76SK6co38qo5Sp0z1U0BSzcIvaZhxvsA2O4J8a+y
         /FwLjh8o+7Y0WDRzJY1AFSDz1UPcLMe7dPNmE1mP758udrYi9ievvgpzkJbN0bwLNaGy
         oNDVlwW6rliIyKdcYK6+cyD97+/qMJmMMT1QchLtC21mctuRQrgEMPkQCpdig0lEOi4V
         Eod6Vvhy3KhabCa4vvevjE3jrGTrENr8V+T872Y0fX1zSmDlcpXFIJxbjth9m7XoS4FS
         sjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QvJYouHy09oKF9oCn/Pwojut4WOcI15TXey54NPggiY=;
        b=ugyECZtaKFLaUASTGg7YoTtGBtksDd55/txKZY3B4HKs6cu3yFEU4pjP/Knsj5OKRB
         4a5WQZeYtq+q4oVh41/gs100v+CSCiDCMrJNGdLA5EjQ5fgnTawGmruTQhudwc8cEGAI
         K6+OKvLyh89d5AsePSDBVSyh8N/liftk58GoHFTkWfHjQVw7RPjyphWJviCho6KX3KK/
         reqsctA+TsZkWLPb43kaWfFcySoR8RiH/asd0LY7uFFvgvQnTO2ro5q44ZiEoa0poxA3
         6CBCNgsU6P74C3nDBAzDXOzJGaD7I2KVhSEAhjDHPh74FvWCbJkaQWbkSIupljI0PIEv
         IqcQ==
X-Gm-Message-State: APjAAAXHf7OdPH5T5/1OBpz/bH+OlQNhnb4YLU+xPR7DnNyGUdgaC2+I
        rpnFIhsRPPKL3fyERcOFohGCjvEgoX19isbO6PplcA==
X-Google-Smtp-Source: APXvYqyaxaAKDIYEaU7fe4jqgDWUm15ZEVSg/w0s+JwklmLGsFnc8go5ACIw5mkjejBVtmGopMPZrorrlUdhG6yN6W4=
X-Received: by 2002:a67:f995:: with SMTP id b21mr10431645vsq.130.1569924671878;
 Tue, 01 Oct 2019 03:11:11 -0700 (PDT)
MIME-Version: 1.0
From:   netman3d <netman3d@gmail.com>
Date:   Tue, 1 Oct 2019 12:11:00 +0200
Message-ID: <CAEtwUJ8t6TfVXaEkEiGwUS=CQz6SQSijX8aPC+bxpTwWO7YXtg@mail.gmail.com>
Subject: iwlwifi regression patch for stable kernel 5.3.x
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch to fix a regression in the iwlwifi modul is
currently not in the pipeline for the stable kernel 5.3.x?

https://patchwork.kernel.org/patch/11158395/

Checked Kernel:
5.3.1

Card:
03:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)

Current Firmware:
iwlwifi-8000C-36.ucode release/core33::77d01142


Best regards
