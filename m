Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92235C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712E6206E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKMVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:17:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328B7206E3;
        Wed, 13 Nov 2019 21:17:57 +0000 (UTC)
Date:   Wed, 13 Nov 2019 16:17:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH resend] libtraceevent: fix parsing event argument types
Message-ID: <20191113161754.47bf2c36@gandalf.local.home>
In-Reply-To: <157338066113.6548.11461421296091086041.stgit@buzz>
References: <157338066113.6548.11461421296091086041.stgit@buzz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2019 13:11:01 +0300
Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Add missing "%o" and "%X". Ext4 events use "%o" for printing i_mode.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo, can you take this?

Thanks! (this time I mean it ;)

-- Steve

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  tools/lib/traceevent/event-parse.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index d948475585ce..beaa8b8c08ff 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -4395,8 +4395,10 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
>  				/* fall through */
>  			case 'd':
>  			case 'u':
> -			case 'x':
>  			case 'i':
> +			case 'x':
> +			case 'X':
> +			case 'o':
>  				switch (ls) {
>  				case 0:
>  					vsize = 4;
> @@ -5078,10 +5080,11 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
>  
>  				/* fall through */
>  			case 'd':
> +			case 'u':
>  			case 'i':
>  			case 'x':
>  			case 'X':
> -			case 'u':
> +			case 'o':
>  				if (!arg) {
>  					do_warning_event(event, "no argument match");
>  					event->flags |= TEP_EVENT_FL_FAILED;

