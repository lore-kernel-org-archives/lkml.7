Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC92083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF1Qfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:35:36 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43173 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Qfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:35:36 -0400
Received: by mail-lf1-f44.google.com with SMTP id j29so4350391lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nwVfPs+vIRBiktClscrgxMmqQM1hwDrGpHuR2rGCVDY=;
        b=Kbjgvam7k4JTQVEWFK6078eWwykDOkjE2i7vOf4h9GfsX7N1BNJfK2V4vFKLSHLd2N
         MrN0eSZo7QpQRKM0L182TiVePNigDuor43/YDCid9cHzS1ZDVnfrGDebnLR0FfuNjDhD
         f7I6K/TUfGndC0dI9mjGg3kOJxYH0XnOfIxUFNMRQedE5CvnP4itSiqBIQeghVFvYXjT
         l52GF3RsnGHNKIuAVOFDLLU1D36AkCrh0rUt1sEUWP1OlpVWB4DPMMbImOPHHXTwddjA
         YAckVdv3nJTOtmFzuVK0jBFXXPkryvhPpCuKKXfI7hCOABCWEAodKETXZxymR0SEgkxP
         jXkA==
X-Gm-Message-State: APjAAAVva1b+tEixTbPiA8YcfdCZwNfzMjLZDYAM+/Rf86oCwwCJfK4S
        F8SPZo60j1oxD1KgzZk5WXhKj+6ZCa77UbixP89siA==
X-Google-Smtp-Source: APXvYqzJTO1posPWsyifEBPmyg1q49r/NpZ6fZUXRp3qxp05xvQunGF0v2b0fJs5viNlmGejRJivqSb/XkLwXVI68Qc=
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr5546835lfn.46.1561739734447;
 Fri, 28 Jun 2019 09:35:34 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 28 Jun 2019 18:34:58 +0200
Message-ID: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
Subject: net: check before dereferencing netdev_ops during busy poll
To:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Elsasser <jelsasser@appneta.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any reason for this panic fix not being applied in stable?

https://lore.kernel.org/netdev/20180313053248.13654-1-jelsasser@appneta.com/T/

It seems that linux 4.9.184 has the bug too.

Regards,
-- 
Matteo Croce
per aspera ad upstream
