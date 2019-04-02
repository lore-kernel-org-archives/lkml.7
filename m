Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C46C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C342084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="LDh0YzSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDBU4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:56:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37856 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:56:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so3916721ply.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYKLdY6VyvyHg5WVumgUzzBQ5B/hLzzNAlcTTAbd+rY=;
        b=LDh0YzSd7555V1WVvFxE+b5+NEnsVT9IlHFA3ybvM9Xyl3TA/CYn/ADGzVu2lGV/mr
         A2HIhA4QqG94oJX3uS8Ok/w0K6oeF1lF/K06ldl06PVcCfoeD5UtYquThwUdy/QnAOtD
         HPJSpchixKboM9B35KnyCh5SJCaPwLx5V93AXu8PNACHAJ7yHklLPuGPaE3DM868BlAB
         a5Y0far0i/OWgPIn80jADs/SJAPGbCl+/xdW7oNy/Wh0lhGg8xiHtL9M7xfgBfGveFSE
         /I1FOfiKM9UHkn0mo+ZjlCTxSC6Xii7qkPbIEamLrQenFG6cffbrdftIx8KWxvvJpBhI
         7QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYKLdY6VyvyHg5WVumgUzzBQ5B/hLzzNAlcTTAbd+rY=;
        b=M/+sO+WR/i3vh6cOj6q9Tf0PQhvBN4QYTf5idMd/vpFkRONYmBsCI+E+Vb+WUod1nx
         hoYfNSoOT4pM4ydtwrXs9uPrSPSQWGGWzJrMBqj5zxEDBtrH0JhJ/sUl8fV0IaR42n+H
         Ku+HzdPF6u1Z6OJykcaQEJTYQy/cfLEIvVJ8iERt3TXA+SVatzyz26iASRJxUzcqu5cK
         t92yvKoPNTD3CWGLcsHtbSN2X7jA1iqaMVibhfdzdxQTGpZT+If/uFk42N8D4Nvi91iW
         CPPNPl3s5wI7RrB2uznUPUFCLraNOQrM0XdOR3+lLFnoyjb9wRc+Q/LgbEEcjC/Xj3i/
         8p1g==
X-Gm-Message-State: APjAAAXkpW1BEble5xPhazKOb1QRuElW44r4JLegk785ZQLM8M95vf2m
        NWc4ixetVJo5Y2JZqnEPxjuzYA==
X-Google-Smtp-Source: APXvYqyP507inA3zCYvSl+UW4Lt1TrnwFd+CigBBWdn6ZfyH533TJ1jJWcdv6LYshg6z0bzdIKecVQ==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr73367002plk.106.1554238606233;
        Tue, 02 Apr 2019 13:56:46 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i10sm13140746pfj.7.2019.04.02.13.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 13:56:46 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:56:43 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Sasha Levin" <sashal@kernel.org>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>,
        "Microsoft Linux Kernel List" <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "Thirupathaiah Annapureddy" <thiruan@microsoft.com>,
        "Sudhakar Evuri" <suredd@microsoft.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190402135643.02443863@shemminger-XPS-13-9360>
In-Reply-To: <20190402193316.15144-2-sashal@kernel.org>
References: <20190402193316.15144-1-sashal@kernel.org>
        <20190402193316.15144-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 12:33:16 -0700
"Sasha Levin" <sashal@kernel.org> wrote:

> +/*
> + * ftpm_tee_tpm_op_recv retrieve fTPM response.
> + * @param: chip, the tpm_chip description as specified in
> driver/char/tpm/tpm.h.
> + * @param: buf,	the buffer to store data.
> + * @param: count, the number of bytes to read.
> + * @return: In case of success the number of bytes received.
> + *	    In other case, a < 0 value describing the issue.
> + */

You are using a docbook style comment but it doesn't start with
docbook prefix.

/**
 * ftpm_tee_tpm_op_recv retrieve fTPM response.
 *
 * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
 * @param: buf,	the buffer to store data.
 * @param: count, the number of bytes to read.
 * @return: In case of success the number of bytes received.
 *	    In other case, a < 0 value describing the issue.
 */
