Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E20CCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33692082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="au4KX5uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634605AbfJRTkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:40:43 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39076 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbfJRTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:40:43 -0400
Received: by mail-pl1-f169.google.com with SMTP id s17so3321820plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEoiaOQ9VoyIfALjC9smztvKnW8HdTQmNEgIo5ubiNQ=;
        b=au4KX5uhtJKbLoX/kJgmTIqOASKiTo68Rs0Yt7JReFBAUqHhZwKcwoj7NycqkOQ7HD
         EPnaSkuzx6IfA++kb4RUx2vt1NzQouVqdQgmFLOvCKV+FyZPEx5fzFdHF9BappstZElQ
         jgMNPrvdJDkcadooBgQz+flaVNOmse2TXf7qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEoiaOQ9VoyIfALjC9smztvKnW8HdTQmNEgIo5ubiNQ=;
        b=p5Kv44efhFcIMMZFb8W2YC6lhk5/k6Uen7vAMj7Pwyp3WThjopYNyo4zP6PD3gXivz
         vjktAXR2WvjUAPbuwH0ycSeyCN7kwRP1RFuViccXwmTyrFYZZtnW5fL+eBMYBp+JtAky
         YP2ix2KrGnsbVTsH9fEDSKDt9qrIDef7gNsfDftWFlHO9yGK+khIW2HN0Fmitbl/MvTL
         fbkXKSueFKZ/e3YWHFXxFIHp8KDl4WGetPoxi/ZKMX5XMAHkKOl/fxKFOfoGjTPVqDY3
         vh/rXvFsofqbZiQ4MDELqgyrXaA+2J7RVRn4hXfPZb5yj4f/LwNphcFTerF2dRPqUSpA
         8PIQ==
X-Gm-Message-State: APjAAAW4fWWDZwSZ63Gdsffqw4jKtOHcW1dVDet7mLpk9AXcog5c9bFP
        Nwi/lXAoGafWLU66iVI8uE2y6w==
X-Google-Smtp-Source: APXvYqy3sWT3xYvAWlmgSMJYw+ObEqJRRqT0xMukcNWhsc5+aeDDEsjDD+ccxbqH+RVLOdHjgVnxcQ==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr11887113plo.189.1571427641966;
        Fri, 18 Oct 2019 12:40:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z2sm7035338pfq.58.2019.10.18.12.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 12:40:41 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:40:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        c-hbandi@codeaurora.org, bgodavar@codeaurora.org,
        linux-bluetooth@vger.kernel.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Add delay for wcn3990 stability
Message-ID: <20191018194039.GB20212@google.com>
References: <20191017212955.6266-1-jeffrey.l.hugo@gmail.com>
 <20191018180339.GQ87296@google.com>
 <CAOCk7NrN0sjLk3onvZn7+bhs_v3A4H6CHh=XPo_NU2XzUWeEGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOCk7NrN0sjLk3onvZn7+bhs_v3A4H6CHh=XPo_NU2XzUWeEGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:30:09PM -0600, Jeffrey Hugo wrote:
> On Fri, Oct 18, 2019 at 12:03 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 02:29:55PM -0700, Jeffrey Hugo wrote:
> > > On the msm8998 mtp, the response to the baudrate change command is never
> > > received.  On the Lenovo Miix 630, the response to the baudrate change
> > > command is corrupted - "Frame reassembly failed (-84)".
> > >
> > > Adding a 50ms delay before re-enabling flow to receive the baudrate change
> > > command response from the wcn3990 addesses both issues, and allows
> > > bluetooth to become functional.
> >
> > From my earlier debugging on sdm845 I don't think this is what happens.
> > The problem is that the wcn3990 sends the response to the baudrate change
> > command using the new baudrate, while the UART on the SoC still operates
> > with the prior speed (for details see 2faa3f15fa2f ("Bluetooth: hci_qca:
> > wcn3990: Drop baudrate change vendor event"))
> >
> > IIRC the 50ms delay causes the HCI core to discard the received data,
> > which is why the "Frame reassembly failed" message disappears, not
> > because the response was received. In theory commit 78e8fa2972e5
> > ("Bluetooth: hci_qca: Deassert RTS while baudrate change command")
> > should have fixed those messages, do you know if CTS/RTS are connected
> > on the Bluetooth UART of the Lenovo Miix 630?
> 
> I was testing with 5.4-rc1 which contains the indicated RTS fix.
> 
> Yes, CTS/RTS are connected on the Lenovo Miix 630.
> 
> I added debug statements which indicated that data was received,
> however it was corrupt, and the packet type did not match what was
> expected, hence the frame reassembly errors.

Do you know if any data is received during the delay? In theory that
shouldn't be the case since RTS is deasserted, just double-checking.

What happens if you add a longer delay (e.g. 1s) before/after setting
the host baudrate?

> In response to this patch, Balakrishna pointed me to a bug report
> which indicated that some of the UART GPIO lines need to have a bias
> applied to prevent errant data from floating lines -
>
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1391888

Yeah, that was another source of frame reassembly errors that we were
seeing on SDM845.

Balakrishna, please post these kind of replies on-list, so that
everybody can benefit from possible solutions or contribute to the
discussion.

> It turns out this fix was never applied to msm8998.  Applying the fix
> does cause the the frame reassembly errors to go away, however then
> the host SoC never receives the baud rate change response (I increased
> the timeout from 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop
> baudrate change vendor event") to 5 seconds).  As of now, this patch
> is still required.

Interesting.

FTR, this is the full UART pin configuration for cheza (SDM845):

&qup_uart6_default {
        /* Change pinmux to all 4 pins since CTS and RTS are connected */
        pinmux {
                pins = "gpio45", "gpio46",
                       "gpio47", "gpio48";
        };

        pinconf-cts {
                /*
                 * Configure a pull-down on 45 (CTS) to match the pull of
                 * the Bluetooth module.
                 */
                pins = "gpio45";
                bias-pull-down;
        };

        pinconf-rts-tx {
                /* We'll drive 46 (RTS) and 47 (TX), so no pull */
                pins = "gpio46", "gpio47";
                drive-strength = <2>;
                bias-disable;
        };

        pinconf-rx {
                /*
                 * Configure a pull-up on 48 (RX). This is needed to avoid
                 * garbage data when the TX pin of the Bluetooth module is
                 * in tri-state (module powered off or not driving the
                 * signal yet).
                 */
                pins = "gpio48";
                bias-pull-up;
        };
};

Does this correspond to what you tried on the Lenovo Miix 630?

> I have no idea why the delay is required, and was hoping that posting
> this patch would result in someone else providing some missing pieces
> to determine the real root cause.  I suspect that asserting RTS at the
> wrong time may cause an issue for the wcn3990, but I have no data nor
> documentation to support this guess.  I welcome any further insights
> you may have.

Unfortunately I don't have a clear suggestion at this point, debugging
the original problem which lead to 2faa3f15fa2f ("Bluetooth: hci_qca:
wcn3990: Drop baudrate change vendor event") involved quite some time
and hooking up a scope/logic analyzer ...

I also suspect RTS is involved, and potentially the configuration of
the pulls. It might be interesting to analyze the data that leads to
the frame assembly error and determine if it is just noise (wrong
pulls/drive strength?) or received with a non-matching baud-rate.

The 50ms delay doesn't really cause any harm, but ideally we'd
understand what exactly is going on.
