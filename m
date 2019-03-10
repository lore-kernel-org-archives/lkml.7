Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E392F207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 14:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="vUSkaB7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCJOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 10:18:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40801 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfCJOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 10:18:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id h1so1738142pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UBeUuahz3SwIwun6oNZ77/CNFgLCx63eAhQ8j9KOEQ=;
        b=vUSkaB7+XZAhNGnQjz0LcmB0Io1giHwCp34YiOZOg0MbTTw1XN9jh5sh+3fbYU1W1Y
         2vB9SMwM27xpI4+gi5x1d6r3vnTIjN/NWMT+LTIgz5bePYcGe13kp+SoILLPe+QSo4CA
         DUm6jeqS5t0lky5QkW0ksLLPyV/nu4h9D1yVEbdNhjMB3G0xcLlpfGJGRJj1ai+9cpce
         NAuCTVnP/A/fzPSSLKArot7f+slPWAuFHPqS0xeVbmcDYmQz+/I7Z7o5r/892D04mWGi
         ydcXYRJMoNvJYNNBNhz3j3Z1rVabD0IxfTpGaL3MNav2XRjU8D9FpQBpk1ifzpj+3KZa
         KNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UBeUuahz3SwIwun6oNZ77/CNFgLCx63eAhQ8j9KOEQ=;
        b=DQJM6lUxcVdjt1D9ZHka0zBZe6ToYCeevTdf+UpbxvK9Jv0op2ud4ZQSopmypa1C0n
         Ed2FTQUnj+P1loBAHxFj4JwrTVyfUaP0TJe6bIKh5goFT7Bh4scriMkUyc93X6vnv70t
         1t32BWTvDlzvOBV/TutymzXvMBIuY7SAx8tKP3ZlSd81Ome7qJHrUThW1g599vVe4kRN
         xWeTk1ET3P9aHYnvhpbHv1mvCQsYJl/nrimQWXHI8Y1SWKz1+L3qfGcm5XbXBpQlp6/y
         fQn9AreOUGeYuBq0OOk7RNZP1I2A399laf5E44ZzNGQndjfOeMUkmELVM4yZttR3g6bt
         Qfbw==
X-Gm-Message-State: APjAAAUPlvYHdmZGc8Tr6Qxq+lTnupHJRQaj7KbZMfzxDrul7VaNxuXw
        H04Tnp1V6OMTQzLRMnlw++TQrA==
X-Google-Smtp-Source: APXvYqyvGnneuIPFHXVn7uMgE94hlt4YmXU/r4wDHiIbl1yjaSEYJ3v58DCo84qMjkLgOTgu5GPtww==
X-Received: by 2002:a62:1752:: with SMTP id 79mr28241583pfx.127.1552227536973;
        Sun, 10 Mar 2019 07:18:56 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id g3sm4481846pgg.41.2019.03.10.07.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 07:18:56 -0700 (PDT)
Date:   Sun, 10 Mar 2019 07:18:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: r8169 only works in promisc mode
Message-ID: <20190310071853.3c726dbc@shemminger-XPS-13-9360>
In-Reply-To: <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
        <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 10:33:40 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 09.03.2019 03:16, Alex Xu (Hello71) wrote:
> > After suspending, my r8169 (not actually 8169, just that driver) only 
> > receives packets when in promiscuous mode. I have tried disabling all 
> > offload features except highdma [fixed], and it doesn't fix the issue.
> > 
> > I am using torvalds/linux, compiled about two days ago (not sure which 
> > commit). I think this happened after a recent upgrade (some time in the 
> > past week). Given the long testing cycle, I don't really want to bisect; 
> > I am hoping someone has some idea of where the issue could be.
> >   
> The provided information isn't enough to say anything. Please create a
> bug ticket in bugzilla. Needed information:
> - Last working and first failing kernel version (as reported by uname -a)
> - Is 5.0 ok?
> - Full dmesg log
> - lspci -vv output for the network card
> - If the issue happens only after resume from suspend, diff of the
>   chip registers (ethtool -d) before and after suspend.
> - Does removing / reloading the r8169 module fix the issue?
> 
> > Please CC me on replies.
> > 
> > Thanks,
> > Alex.
> >   
> Heiner

Bugzilla is not really used by Linux network developers.
I just filter/forward mail from bugzilla into netdev.
