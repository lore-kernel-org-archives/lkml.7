Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F76C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F7121900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCUX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:28:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42436 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:28:14 -0400
Received: from 79.184.255.210.ipv4.supernova.orange.pl (79.184.255.210) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 79154635c086280c; Fri, 22 Mar 2019 00:28:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     David Arcari <darcari@redhat.com>
Cc:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Jirka Hladky <jhladky@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a command
Date:   Fri, 22 Mar 2019 00:26:18 +0100
Message-ID: <1920733.IGH1RQtUIy@aspire.rjw.lan>
In-Reply-To: <1549982079-23516-1-git-send-email-darcari@redhat.com>
References: <1549982079-23516-1-git-send-email-darcari@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 12, 2019 3:34:39 PM CET David Arcari wrote:
> turbostat failed to return a non-zero exit status even though the
> supplied command (turbostat <command>) failed.  Currently when turbostat
> forks a command it returns zero instead of the actual exit status of the
> command.  Modify the code to return the exit status.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jirka Hladky <jhladky@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9327c0d..c3fad06 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5077,6 +5077,9 @@ int fork_it(char **argv)
>  		signal(SIGQUIT, SIG_IGN);
>  		if (waitpid(child_pid, &status, 0) == -1)
>  			err(status, "waitpid");
> +
> +		if (WIFEXITED(status))
> +			status = WEXITSTATUS(status);
>  	}
>  	/*
>  	 * n.b. fork_it() does not check for errors from for_all_cpus()
> 

Applied, thanks!

