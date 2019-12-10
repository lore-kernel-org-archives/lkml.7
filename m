Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4091C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F812073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLJNZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:25:43 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:54240 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLJNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:25:43 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 795F7200A9A;
        Tue, 10 Dec 2019 13:25:41 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 66C1020AB2; Tue, 10 Dec 2019 14:25:19 +0100 (CET)
Date:   Tue, 10 Dec 2019 14:25:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simon Geis <simon.geis@fau.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v2 01/10] PCMCIA/i82092: use dev_<level> instead of printk
Message-ID: <20191210132519.GA58558@light.dominikbrodowski.net>
References: <20191210114333.12239-1-simon.geis@fau.de>
 <20191210114333.12239-2-simon.geis@fau.de>
 <20191210124902.GA3810481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210124902.GA3810481@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 01:49:02PM +0100, Greg Kroah-Hartman wrote:
> > @@ -417,7 +422,9 @@ static int i82092aa_init(struct pcmcia_socket *sock)
> >                                                                                                                                                                                                                                                
> >  static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
> >  {
> > -	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
> > +	struct socket_info *sock_info = container_of(socket, struct socket_info,
> > +						     socket);
> > +	unsigned int sock = sock_info->number;
> 
> 
> This does not look like a printk cleanup :(
> 
> >  	unsigned int status;
> >  	
> >  	enter("i82092aa_get_status");
> > @@ -458,7 +465,9 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
> >  
> >  static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state) 
> >  {
> > -	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
> > +	struct socket_info *sock_info = container_of(socket, struct socket_info,
> > +						     socket);
> > +	unsigned int sock = sock_info->number;
> 
> Nor does this :(

... regarding _get_socket() you are right, but here it is required for the
printk cleanup -- to be able to use dev_info(), struct device needs to be
made accessible. So this change seems fine to me.

Thanks,
	Dominik
