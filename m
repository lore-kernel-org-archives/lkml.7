Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE43C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEF325683
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tilSS707"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfE3Hmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:42:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41619 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3Hmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:42:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id y15so1785555edo.8;
        Thu, 30 May 2019 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tR6oFkuBAFmgDTWPVe99/T3by59QSZTbj6hDFEpZ3MA=;
        b=tilSS707XPtzijZ7eNz1A8IiWDOqHC9qIp4gHvwmnNaLLlhvaT9gZRdjcenI49LOxu
         iEkyBrBNIeHg5mTeKiEWKiOobg4Cnc9ro8Vy6PStJ71qobphay5YC36ttZZrdS+xbaNu
         JWNNr2pMy74vpfOjn5jX89qNwFiXReTluPKE/t188KQtAyWdZQpdCYNWCcE/x/tjnbP7
         D4SeBMkTetHewzwh5QYiOi0ZmQxawg4SSRuydJ9zuHzZDjurtE999MbrWFqlMBFCyGV5
         tNITJPxDpoRQevNVNd1efkmcaCFjxQvJpCp9LuLbsnSj/B6jr9VFMzdrGsyrHmdCkOjR
         7/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tR6oFkuBAFmgDTWPVe99/T3by59QSZTbj6hDFEpZ3MA=;
        b=RYVVrNUfNU8OCUpSleHi48Aul+ZA+PKcJFiHSFvmT4KLMpnfg7znZO7ibFzn1mkt2B
         rR+GAQcwUURQATaPuaB/4UGjvoHi/fBw7szpIqSueYAETv+7nv6TqLWncRen5eK0u0+A
         iMvNjHuYn7pkbRvxHcsn1/siedR3y8wbFKzO18IashyEwIPdLhVAAoCOuWISE1GOMHy5
         LhtCVVom2U8S9hv7ETIo3VusG/MZk0RalOptBSra/UIqniStQBmlIy7+hBRhabY9EV3b
         0UPyUEYq1jV/y5q/gLMRHF8A+hFTYurmrjG6QAHTw499PMTBefz1xA0cIK3fNEjM3iS/
         Drgw==
X-Gm-Message-State: APjAAAWETP27U0XYBRJq6m5qcEsdWd9+4Mp+0aRCsw3s+6hBOpac5wwg
        +27zDPY28GnXqbLA1s+GAQafL/1+ThwdY5A9QfM=
X-Google-Smtp-Source: APXvYqxcRL1ZnXMIuVmQ+r/MZi4UjRNEt/Cxv6q63hjLFkgJ5cVJ7MhLQm0poEGyhiToWZmBJ9YStuCokpxv6I4JYWk=
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr2111799ejs.15.1559202172491;
 Thu, 30 May 2019 00:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235627.1315-1-olteanv@gmail.com> <20190528235627.1315-4-olteanv@gmail.com>
 <20190529044912.cyg44rqvdo73oeiu@localhost> <CA+h21hoNrhcpAONTvJra5Ekk+yJ6xP0VAaPSygaLOw31qsGPTg@mail.gmail.com>
 <20190530035112.qbn3nnoxrgum7anz@localhost>
In-Reply-To: <20190530035112.qbn3nnoxrgum7anz@localhost>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Thu, 30 May 2019 10:42:41 +0300
Message-ID: <CA+h21hqko57LB0BB2TSGSr4p9_czPM-g9krO+wnU7PgvaMdSDA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: dsa: mv88e6xxx: Let taggers specify a
 can_timestamp function
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 at 06:51, Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 11:33:31PM +0300, Vladimir Oltean wrote:
> > I would like to avoid keeping meta frames in their own RX queue,
> > because then I'm complicating (or rather put, making impossible) the
> > association between a meta frame and the frame it holds a timestamp
> > of.
>
> We have an example of how a driver can match meta time stamp packets
> with received packets.  See drivers/net/phy/dp83640.c to see how it
> can be done completely within the driver.
>
> Thanks,
> Richard

The meta frames generated by the SJA1105 do not contain any seqid.
They contain:
* A globally programmable DMAC
* A globally programmable SMAC
* The 0x8 EtherType
* A partial (24-bit or 32-bit) RX timestamp
* Two bytes from the initial (pre follow-up) frame's DMAC, before the
switch mangled those with the source port and switch id. The driver is
supposed to patch these bytes from the follow-up back into the initial
frame before passing them up the stack.
* The source port that generated the meta frame
* The switch id that generated the meta frame

Regards,
-Vladimir
