Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DFA2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LodsJjm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfJVSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:35:28 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44485 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfJVSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:35:28 -0400
Received: by mail-lj1-f181.google.com with SMTP id c4so3165097lja.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=d4Vj26TGvpT8Pp948ejBZToOMkzRLVxh6k+58Wg2xwg=;
        b=LodsJjm6yZ9LOjHCZEgtJxPVD8w+jNkfjFrQS54WsJ6WEloyHeuGDp9UTETDxo91W2
         Y2of27/MtHkxOMFUQNn2NnAJHBfewC+ZziwnsRgEFEBl6FfCkxUpiGSwuF5krICiJz1j
         OgZ7/ClTmcOpHiTytb9h1kvKp9vuaSxqy1C88K05ebjWoH86JlZZpl+EiCs+PNAHrVL6
         wQDyZJhRXkuygo0Bui0hDSKV/UKgirFVjAU8eMYihfCdaBkZK430xDM3GFg/IDA5Acdq
         rhmjprkxZToDzITWkcg9ydTi1JULGf17T+fbWu2TWDGEc+05cFJArKuGGqJtYzgDUsgA
         KGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=d4Vj26TGvpT8Pp948ejBZToOMkzRLVxh6k+58Wg2xwg=;
        b=krHJlpX3lakOVu11fROrSB3ckoZsi6bWefz5p2KzmaiUcPqDB25W6HDCNt6BVUDRAe
         x5ozQWjeTCSeAzDjdkGSbpe8e/AYHohancDnxlnQ/Rt0sdtwO2Zyb1mR+gvTgN3r3/uU
         5kTbH8wSOsIgm08PAW4lK1qi5fIrcG2MQCiHmOp3uDhmvmsOJ9oYNKgYBBeXUD8UtGm5
         /3m0ZTSN/g5UokzJqt84rU+IqiWyR9Q7h9jN5thmooR6Tb8ZlsD7F2GvIFkJtaBfYSbr
         9OXfW0BIXFu2dl2/LB+a6YjumamWoA7aUdQRR6Y5xRBPHBYZnCm8IS58KMCjBLtiaU5Q
         zyAg==
X-Gm-Message-State: APjAAAVJr/wmgqQJTByoDrp25JJALNWLUfWtDC1l72Mkit7zsYg7avTS
        t6i6VbxGmBQMxC/8rX2J4mUcZ6Yvm4o=
X-Google-Smtp-Source: APXvYqw2hpKR+LmLpH9nt6R/Lr+GpVj8pTxyVu9B9jUaIrwacwn5DW2rt/eNMqk8oikwYa1unkr0zA==
X-Received: by 2002:a05:651c:30f:: with SMTP id a15mr3287332ljp.97.1571769325806;
        Tue, 22 Oct 2019 11:35:25 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o5sm6592526lfn.78.2019.10.22.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 11:35:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:35:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <pmalani@chromium.org>,
        <grundler@chromium.org>
Subject: Re: [PATCH net-next 0/4] r8152: PHY firmware
Message-ID: <20191022113516.15c2313b@cakuba.netronome.com>
In-Reply-To: <1394712342-15778-330-Taiwan-albertk@realtek.com>
References: <1394712342-15778-330-Taiwan-albertk@realtek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 11:41:09 +0800, Hayes Wang wrote:
> Support loading the firmware of the PHY with the type of RTL_FW_PHY_NC.

Applied, thanks!
