Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCFDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E662084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554280001;
	bh=VrdmJMUdb7I9TXBgKTo7IRCWyph2KbU/hsHFEr+MAgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jpLnLfbBZrqbcyo1+fS+tIKI3+VLXdGd0BMso+nw5QSNaQf8v5ku1CAI3BzaZwijf
	 Soild5hRQYhdrdrruXrD56zk/PD8KG+5iEHWYqzqvrf2RTpOBNsx+KWrElsMK4mp1t
	 YRzAmMcc0M825utn/HnT7hXlRBseBnhsQxXA4xOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDCI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:26:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40422 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:26:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so11029844lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKayWre1k/uhqb6AX0DLMxMElkzD/gI+OlZ55di6lpE=;
        b=HyFhceDdPA6en1X5C0iCvFIGj7ZJOqKfN2ty2O97fT0LM1DxgTNbp/Y7Cwcp3egIWE
         r3flvRuIPv2ayA1UPlOKr6vgoz5rO/ofDAeTla2qxZh2W3ejweI0tc5CsCYZ+yR9smOX
         h1TbUB9RdhVOGWmt7uVovWydqaUPmfFhcHY7rXQgJLlaWvFOfMgsNeFqKHf4ah7gHGMu
         ophUwnb6pYFY3h5EFClJGJ+ZOTPqwTFTbshH2mSelUmQV1tdJpHLtvBO+TDd2CEQqkBB
         ho+bo/8eO6JPH/5fVxqMSLXJWzOPPnPIBhmOx7jG0kqIqAniFmbGyfpn9NNg6w91l4Pz
         Iv7Q==
X-Gm-Message-State: APjAAAVs6ctj7cWNO3Y5VaFv4Cbxq6d6oaY1i7IbS20XfmrtEAGbR6U9
        NWU60GHNHBl1IkeAPUmPVZVHK8P5
X-Google-Smtp-Source: APXvYqzUMTMZRTlwyjJfNmP3dI/ctfmC72firxePSMZs9XhqZgxECtI6sS65OMUvI7f4OT5FPChbWg==
X-Received: by 2002:ac2:530a:: with SMTP id c10mr9632013lfh.45.1554279997633;
        Wed, 03 Apr 2019 01:26:37 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s10sm2819161lfc.20.2019.04.03.01.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:26:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBbEY-0004Wv-Px; Wed, 03 Apr 2019 10:26:58 +0200
Date:   Wed, 3 Apr 2019 10:26:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: Re: [PATCH] Revert "tty: fix NULL pointer issue when tty_port ops is
 not set"
Message-ID: <20190403082658.GG6734@localhost>
References: <20190403074053.5961-1-johan@kernel.org>
 <20190403080649.GA12019@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403080649.GA12019@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:06:49AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 03, 2019 at 09:40:53AM +0200, Johan Hovold wrote:
> > This reverts commit f4e68d58cf2b20a581759bbc7228052534652673.
> > 
> > TTY drivers using the tty-port abstraction all provide a pointer to a
> > set of port operations, which specifically cannot be NULL (or we'd find
> > out at first attempt to open a port).
> > 
> > Revert the recent commit which added unnecessary NULL-checks and whose
> > commit message indicated that it was fixing a real problem, which it did
> > not.
> > 
> > Note that even the two tty drivers for virtual devices currently
> > providing an empty set of operations probably should be implementing at
> > least some of the callbacks.
> 
> This was a "future fix" for a driver that is under review for 5.2, see
> the email thread:
> 	Subject: [PATCH 0/2] TTY: add rpmsg tty driver
>
> It didn't want/need the port pointer, if that is incorrect, that's fine,
> I'll gladly revert this, but as-is this patch isn't hurting anything,
> right?

No, it only adds the unnecessary NULL checks and some confusion by
claiming to "fix an issue".

The rpmsg tty driver not having to do anything at activate/shutdown
(first open, final close) looks a bit suspicious, but in any case I
think it's the outliers that should continue providing an empty set of
callbacks instead of sprinkling conditionals in core.

Johan
