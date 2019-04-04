Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E382082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJNHxbec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDDRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:21:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38371 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfDDRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:21:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so2374605lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWEKv1NMWIXiFhq23uo1NeSiJc8e43y5G2cJ0bGNTbM=;
        b=YJNHxbecPF0ms7B3c9l4EGrQH6ECiqr7q+za9T2PW9134zoLGG+Qu/0lL0jHFki7G1
         QXCFAM6TweMWpI539dPuiuXxZvQcrs7NLoKmgJ9zk/ThbHVKwAFeQOvEouCXpyUWtigg
         JeP4RtQiusUun5r+eTVAV6RkMZfc21fvCyJgwU//wYJXKo4U5Ag+reV6as2o/t1AoOgo
         RFYZPcXFfwGKimNwmfyDcnNGazgrE//p2k6YNsaOFcI5TMC+oEqXEiCRTqSKHqO4beR8
         WE1jcYV9yS67pwWb/hRRxrdBGTiTDkmpPffeXLP6A9GnOoJIEFOrfcojo+F4QpiN7yS6
         TswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWEKv1NMWIXiFhq23uo1NeSiJc8e43y5G2cJ0bGNTbM=;
        b=GVYKfQU6TZBSpdLUNXfGOZ3Z2Uqo9bzdaS5qAzKvyrpdr1+8Y42fUkC4NTRPD4qLxT
         lpzP4a43C7N+ceaCf6aF9wCfeUh+6Hpnz02NJx6rDc86OHUqmpciDswocKqVGOISwnp0
         tTjvprOAUN5NqfCp/Xn7vwZ9piVMXbwqdPfWKDlyvrC40Tpo7aUHLOM7T4Z5kOEzjdS8
         GeHoTwX2/R/OBq8oW9sWC7ddZkYseSq1NdyIBbZPCEQefskbQE7JT00jbOzjQQPnteIg
         eaaXhCdd5FgMOSWe1y4NfydALqLA2nAVGD03LCabjzXOpWOxE8SE7SJ4mqioA2sSDSUV
         yebQ==
X-Gm-Message-State: APjAAAVxlqvHYSySch6aDJhje9VbutVmVH+eiFSw9cPwK5Jr2K8408l0
        Y8q7w8mkCKP5daX84xy2NFE=
X-Google-Smtp-Source: APXvYqwX2OOtfhHY2DL3v1nRqPQ/q7eIwBHPwp188mKsSpo5w7gnU21d7a4viryln88M9dXopIc/mw==
X-Received: by 2002:a19:ca02:: with SMTP id a2mr4063942lfg.88.1554398491330;
        Thu, 04 Apr 2019 10:21:31 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id y10sm3742431lfg.44.2019.04.04.10.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:21:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 4 Apr 2019 19:21:22 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND PATCH 1/3] mm/vmap: keep track of free blocks for vmap
 allocation
Message-ID: <20190404172122.2u5g4eppkn7zcunh@pc636>
References: <20190402162531.10888-1-urezki@gmail.com>
 <20190402162531.10888-2-urezki@gmail.com>
 <20190403210644.GH6778@tower.DHCP.thefacebook.com>
 <20190404154320.pf3lkwm5zcblvsfv@pc636>
 <20190404165240.GA9713@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404165240.GA9713@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Do we need this change?
> > >
> > This patch does not tend to refactor the code. I have removed extra empty
> > lines because i touched the code around. I can either keep that change or
> > remove it. What is your opinion?
> 
> Usually it's better to separate cosmetic changes from functional, if you're
> not touching directly these lines. Not a big deal, of course.
> 
OK. I will keep it as it used to be. When it is a time for refactoring we can 
fix that.

> > > 
> > > The function looks much cleaner now, thank you!
> > > 
> > > But if I understand it correctly, it returns a node (via parent)
> > > and a pointer to one of two links, so that the returned value
> > > is always == parent + some constant offset.
> > > If so, I wonder if it's cleaner to return a parent node
> > > (as rb_node*) and a bool value which will indicate if the left
> > > or the right link should be used.
> > > 
> > > Not a strong opinion, just an idea.
> > > 
> > I see your point. Yes, that is possible to return "bool" value that
> > indicates left or right path. After that we can detect the direction.
> > 
> > From the other hand, we end up and access the correct link anyway during
> > the traversal the tree. In case of "bool" way, we will need to add on top
> > some extra logic that checks where to attach to.
> 
> Sure, makes sense. I'd add some comments here then.
> 
Will put some explanation and description.

Thank you!

--
Vlad Rezki
