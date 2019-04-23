Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A9DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73520835
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFtB6KCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDWR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:57:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33677 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfDWR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:57:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so7913261plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/c0VAKrebet1xFE4ZU1kPtC1ZGWlTTNfkUjUjXJ3LZM=;
        b=hFtB6KCreBGR8DZW+qEJrdmY1IL41Vvs2Rk5vLtADjR87ILeChYUJVnfrD87iv4mz5
         PaEjFj/BEZaihxLokafZ2voGsNqYPGCnr6na0Z3uKKeQZemqluiZB/9ZOjCQ25DnAHn2
         AbQ5fIbMiq5ME0P4iyg1z9iTeBCVlnf4IGilw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/c0VAKrebet1xFE4ZU1kPtC1ZGWlTTNfkUjUjXJ3LZM=;
        b=tfA2yiV0TgZ4r/FE9NaY9xyqwfmxL9aPNrW4jhlbEzUjJ56yRizKMhLNsXixOU1r3J
         tkfYHW46I+BwejRdAyD0S/0aoKNcKMKiO8J710h1W1kQSO1tkfCW0CzuQLhgKiaaGfRU
         H9sKzl8HPPey/J/bZ4IlgECsub4NFEHU/I+YQUC8SvLGqr4lSLRFiuf56TpeJtRr0l4+
         LOO/aXzu0Sp6c0OIjZ7vw2uJyHhDwtJV4QC6/0ST6aXnFLj2Hqw+8NgbMwzyR6eQAhbN
         obH1S6cJ04OH9ToHT5mmyVlMmLnN56mllJxY7EKV/nyzylhCVHu8fzq0fvORaHHX6UXz
         VxWg==
X-Gm-Message-State: APjAAAWiEJ6hBJigbChmVbJcNfs0FK4KHpeDJ6L1edTwiAArr9FySAN+
        xQsZT8R4W+vDNReZ/8TBtRvPGMWRBJTozQ==
X-Google-Smtp-Source: APXvYqyqs1i2BjOCruFSSkhGKAZ8/YSOp7QUwwQ3VnkcmFF/1pz4s0QsF3zqQU2lr9q6/pTd5bb86Q==
X-Received: by 2002:a17:902:7b8e:: with SMTP id w14mr9341109pll.202.1556042276306;
        Tue, 23 Apr 2019 10:57:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r87sm28704099pfa.71.2019.04.23.10.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 10:57:55 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:57:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix crash with non-serdev devices
Message-ID: <20190423175754.GC112750@google.com>
References: <CAG5bF+TCPc=m_O33RHXHrt34T1Dz1zHLSkXfpxAoOTmrffGJ7w@mail.gmail.com>
 <32C292F9-34DF-436F-896E-A219D961218F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32C292F9-34DF-436F-896E-A219D961218F@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:26:40PM +0200, Marcel Holtmann wrote:
> Hi Matthias,
> 
> > qca_set_baudrate() calls serdev_device_wait_until_sent() assuming that
> > the HCI is always associated with a serdev device. This isn't true for
> > ROME controllers instantiated through ldisc, where the call causes a
> > crash due to a NULL pointer dereferentiation. Only call the function
> > when we have a serdev device. The timeout for ROME devices at the end
> > of qca_set_baudrate() is long enough to be reasonably sure that the
> > command was sent.
> > 
> > Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm
> > Bluetooth chip wcn3990")
> > Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > Reported-by: Rocky Liao <rjliao@codeaurora.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > drivers/bluetooth/hci_qca.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 4ea995d610d2..714a6a16f9d5 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1004,7 +1004,8 @@ static int qca_set_baudrate(struct hci_dev
> > *hdev, uint8_t baudrate)
> > 	while (!skb_queue_empty(&qca->txq))
> > 		usleep_range(100, 200);
> > 
> > -	serdev_device_wait_until_sent(hu->serdev,
> > +	if (hu->serdev)
> > +		serdev_device_wait_until_sent(hu->serdev,
> > 		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> 
> somehow I get a malformed patch when I try to apply it. Can you send a new version against bluetooth-next with all tags added.

Dunno what happened there, I'll send a new version with the tags in a
bit.

Thanks

Matthias
