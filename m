Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6BC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79938218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgep8XUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGEJHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:07:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33742 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGEJHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:07:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so4035221pgk.0;
        Fri, 05 Jul 2019 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oAbtO0VVEgPrns4ECpP/l7PElOulKUdNK8WJ9smHNMY=;
        b=Tgep8XUSV0dm/4njOv+mq3T9bmSTqiX2/FXEOlNqGtx6ARJjfBTy7NN3QIRxz+fDwf
         a5nYIv9Z26yE+U4P8icDrSSzw2c33eauBtLiQkMaOwZSW14zK21kIsQHZT/gPkHMGlQU
         sWme3teVQ7zob+AJqr3DZIV5TaJHR6Vo1cm6mjfjPcoWq28iB54FPan93CNGTzLgUiVK
         Jurj+8efcZJSx0U4m7zoZYxeNpMDkvyktFmW+RjxOe3hVAGD4yI0EOL1Q+d0KWZASk6Z
         QbpLmcrgRhHTC3LZ2KX2Ri9NtzBXM1VsnxZreuqJxgeA0DeJxl9oYN/Q+hbaCplVXpIh
         iiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAbtO0VVEgPrns4ECpP/l7PElOulKUdNK8WJ9smHNMY=;
        b=WO62YA4W7nU9TrxrqKxXvP+oecgqnQllLhxRSXjiHxIapJmVK9fEJw9Ksm82RZZHgq
         /cgvPZiHiyV+ThxHOFXZxffxS2ioAL+elOUKOz+QBX44C5Bz/tceTATr5KHDgbMMiw6e
         dCucNwDWsXThS5qWJ5my+hDcv2v48GyCgQkBwzRon65BByi5ImlU0XqPpHqDkbNEVvPT
         rzR4f8YRp58hZfe2hGNZMpDQ84bJmJXV1oilBjZX2jIoHqrfQvwv53rPhOjQqQqzIPO3
         Y2Ah9HHx1Lnaf4ee2PEvK1W0q+4waUc8/g4AloZwMD+7QgSnMwV777yR+/AgafXA/BSS
         O8SA==
X-Gm-Message-State: APjAAAV4+yZj4/JslhZ9t4SeSblG9VDB45HA93kPfwMqOqzoBWF85Ggk
        12IGLHx2v02jdypXuHmL1AA=
X-Google-Smtp-Source: APXvYqyCLI0BwJN0qCmMnQOPG1rfLeBXg7tea+um46myS9fGSPFJ6NaKneXX18rGafWT/n39F5kHYw==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr4012219pjp.27.1562317634927;
        Fri, 05 Jul 2019 02:07:14 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id x26sm8587339pfq.69.2019.07.05.02.07.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:07:14 -0700 (PDT)
Date:   Fri, 5 Jul 2019 18:07:09 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
Message-ID: <20190705090708.GA3251@localhost.localdomain>
References: <20190704172435.GA11673@localhost.localdomain>
 <Pine.LNX.4.44L0.1907042138091.840-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1907042138091.840-100000@netrider.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:41:04PM -0400, Alan Stern wrote:
> On Fri, 5 Jul 2019, Suwan Kim wrote:
> 
> > On Mon, Jun 24, 2019 at 01:24:15PM -0400, Alan Stern wrote:
> > > On Mon, 24 Jun 2019, Suwan Kim wrote:
> > > 
> > > > > > +	hcd->self.sg_tablesize = ~0;
> > > > > > +	hcd->self.no_sg_constraint = 1;
> > > > > 
> > > > > You probably shouldn't do this, for two reasons.  First, sg_tablesize
> > > > > of the server's HCD may be smaller than ~0.  If the client's value is
> > > > > larger than the server's, a transfer could be accepted on the client
> > > > > but then fail on the server because the SG list was too big.
> > > 
> > > On the other hand, I don't know of any examples where an HCD has 
> > > sg_tablesize set to anything other than 0 or ~0.  vhci-hcd might end up 
> > > being the only one.
> > > 
> > > > > Also, you may want to restrict the size of SG transfers even further,
> > > > > so that you don't have to allocate a tremendous amount of memory all at
> > > > > once on the server.  An SG transfer can be quite large.  I don't know 
> > > > > what a reasonable limit would be -- 16 perhaps?
> > > > 
> > > > Is there any reason why you think that 16 is ok? Or Can I set this
> > > > value as the smallest value of all HC? I think that sg_tablesize
> > > > cannot be a variable value because vhci interacts with different
> > > > machines and all machines has different sg_tablesize value.
> > > 
> > > I didn't have any good reason for picking 16.  Using the smallest value 
> > > of all the HCDs seems like a good idea.
> > 
> > I also have not seen an HCD with a value other than ~0 or 0 except for
> > whci which uses 2048, but is not 2048 the maximum value of sg_tablesize?
> > If so, ~0 is the minimum value of sg_tablesize that supports SG. Then
> > can vhci use ~0 if we don't consider memory pressure of the server?
> > 
> > If all of the HCDs supporting SG have ~0 as sg_tablesize value, I
> > think that whether we use an HCD locally or remotely, the degree of
> > memory pressure is same in both local and remote usage.
> 
> You have a lot of leeway.  For example, there's no reason a single SG
> transfer on the client has to correspond to a single SG transfer on the
> host.  In theory the client's vhci-hcd can break a large SG transfer up
> into a bunch of smaller pieces and send them to the host one by one,
> then reassemble the results to complete the original transfer.  That
> way the memory pressure on the host would be a lot smaller than on the
> client.

Thank you for the feedback, Alan. I understood your comment. It
seems to be a good idea to use sg_tablesize to alleviate the memory
pressure of the host. But I think 16 is too small for USB 3.0 device
because USB 3.0 storage device in my machine usually uses more than
30 SG entries. So, I will set sg_tablesize to 32.

Regards

Suwan Kim
