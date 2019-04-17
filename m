Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB94C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D78217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfDQVQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:16:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50860 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:16:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGrv4-0007ri-3U; Wed, 17 Apr 2019 21:16:38 +0000
Date:   Wed, 17 Apr 2019 22:16:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 04/26] compat_ioctl: move PPPIOCSCOMPRESS32 to
 ppp-generic.c
Message-ID: <20190417211637.GV2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-5-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:42PM +0200, Arnd Bergmann wrote:
> +#ifdef CONFIG_COMPAT
> +struct ppp_option_data32 {
> +	compat_caddr_t	ptr;

Huh?  compat_uptr_t, surely?  I realize that compat_ioctl.c is bogus
that way right now, but let's not spread that crap into the places
where it's harder to find...

>  	err = -EFAULT;
> -	if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
> -		goto out;
> +#ifdef CONFIG_COMPAT
> +	if (compat) {
> +		struct ppp_option_data32 data32;
> +
> +		if (copy_from_user(&data32, (void __user *) arg,
> +				   sizeof(data32)))
> +			goto out;
> +
> +		data.ptr = compat_ptr(data32.ptr);
> +		data.length = data32.length;
> +		data.transmit = data32.transmit;
> +	} else
> +#endif
> +	{
> +		if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
> +			goto out;
> +	}

*UGH*

Do that in caller, please.  And sod the flag argument...
