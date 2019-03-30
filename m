Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3972C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB6218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfC3MA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:00:29 -0400
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:40768
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730384AbfC3MA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:00:28 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 08:00:26 EDT
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8D671BE0CA3;
        Sat, 30 Mar 2019 11:54:12 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-1.ch.mailchannels.com [46.232.183.5])
        by relay.mailchannels.net (Postfix) with ESMTPA id 68AC2BE0C60;
        Sat, 30 Mar 2019 11:54:03 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.155])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Sat, 30 Mar 2019 11:54:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Trade-Continue: 27f30e331c53dcfd_1553946852120_2575866182
X-MC-Loop-Signature: 1553946852120:1503120581
X-MC-Ingress-Time: 1553946852119
Received: from [80.219.231.201] (port=47868 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1hACYg-0004VR-L1; Sat, 30 Mar 2019 12:53:58 +0100
Message-ID: <f0d590b96b7d11ae21a9a06040b8ffa85fa74e2a.camel@bitron.ch>
Subject: Re: [PATCH v2 2/5] pid: add pidfd_open()
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Christian Brauner <christian@brauner.io>, jannh@google.com,
        luto@kernel.org, dhowells@redhat.com, serge@hallyn.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        keescook@chromium.org, adobriyan@gmail.com, tglx@linutronix.de,
        mtk.manpages@gmail.com, bl0pbl33p@gmail.com, ldv@altlinux.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com
Date:   Sat, 30 Mar 2019 12:53:57 +0100
In-Reply-To: <20190329155425.26059-3-christian@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
         <20190329155425.26059-3-christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 16:54 +0100, Christian Brauner wrote:
> diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> index ac49a220cf2a..d6c7c0701997 100644
> --- a/include/uapi/linux/wait.h
> +++ b/include/uapi/linux/wait.h
> @@ -18,5 +18,7 @@
>  #define P_PID		1
>  #define P_PGID		2
>  
> +/* Get a file descriptor for /proc/<pid> of the corresponding pidfd
> */
> +#define PIDFD_GET_PROCFD _IOR('p', 1, int)
>  
>  #endif /* _UAPI_LINUX_WAIT_H */

This is missing an entry in Documentation/ioctl/ioctl-number.txt and is
actually conflicting with existing entries.

However, I'd actually prefer a syscall to allow strict whitelisting via
seccomp and avoid the other ioctl disadvantages that Daniel has already
mentioned.

Cheers,
Jürg

