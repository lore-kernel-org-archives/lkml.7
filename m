Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8745C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A915721773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfC1Maj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfC1Maj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:30:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB53B2082F;
        Thu, 28 Mar 2019 12:30:37 +0000 (UTC)
Date:   Thu, 28 Mar 2019 08:30:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Life is hard, and then you die" <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190328083036.7398db1b@gandalf.local.home>
In-Reply-To: <20190328112952.GA2232@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
        <20190327014807.7472-4-ronald@innovation.ch>
        <20190327023757.GB20766@kroah.com>
        <20190328002817.GF24753@innovation.ch>
        <20190328052917.GB18668@kroah.com>
        <20190328102755.GA26446@innovation.ch>
        <20190328112952.GA2232@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 12:29:52 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> >   3. In at least two places we log different types of packets in the
> >      same lines of code (protected by a "if (log_mask & PKT_TYPE)") -
> >      dynamic-debug would only allow enabling or disabling logging of
> >      all packets. This could be worked around by creating a separate
> >      (but essentially duplicate) logging function for each packet type
> >      and some lookup table to call the appropriate one. Not very
> >      pretty IMO, though.  
> 
> True, but you can use tracepoints as well, that would probably be much
> easier when you are logging data streams.  You can also use an ebpf
> program with the tracepoints to log just what you need/want to when you
> want to as well.

And tracepoints have filters where you don't even need ebpf to do such
filtering.

See Documentation/trace/events.rst Section 5: Event Filtering

-- Steve
