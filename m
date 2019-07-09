Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E212C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8212087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gufTxBzN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xks7+qKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIRhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:37:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60058 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:37:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C754C161342;
        Tue,  9 Jul 2019 13:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ZPzL96906deSPszntNDHK2QFX3M=; b=gufTxB
        zNSe+0divwYcBXwLhl9W3sFW7BjvHwmRzFddQ05k36d7tv2a25UjIIOxanJXoOtD
        ynWmKEeObbiHF4Wvmzj5VKMD2JqVBTuU5B/1bWCi1zttldwtRQOxwxGPf3VwFHae
        ZTVdmAa/irDQ+ccsim1Jzz0QckHhqwsrggLFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE41C161341;
        Tue,  9 Jul 2019 13:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=JUWCum9pcbTPQLn3Li5UWdFaYelziHmHH3PL7HgMqUA=; b=xks7+qKO5WD+kKbJjFOF8VQyA5IpsnEK4OFwGE8D3PZDdxs5jke6gTQYNTNVpTuw+9lZxor+rnj4Og4V3l/KkAFJFxOEdbqgqYP59TtxNtwcnTTVeAbnmcjK6S4EqKV6l5owBWQteKjscyC6KqLyM/GwiQFONIgs423mD66FaEE=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43457161340;
        Tue,  9 Jul 2019 13:37:51 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5E86E2DA0192;
        Tue,  9 Jul 2019 13:37:50 -0400 (EDT)
Date:   Tue, 9 Jul 2019 13:37:50 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 08/11] kbuild: create *.mod with full directory path and
 remove MODVERDIR
In-Reply-To: <20190709042416.27554-9-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1907091332150.4190@knanqh.ubzr>
References: <20190709042416.27554-1-yamada.masahiro@socionext.com> <20190709042416.27554-9-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 466A70CC-A270-11E9-96DF-46F8B7964D18-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019, Masahiro Yamada wrote:

> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -47,13 +47,10 @@ cat > "$new_ksyms_file" << EOT
>   */
>  
>  EOT
> -[ "$(ls -A "$MODVERDIR")" ] &&
> -for mod in "$MODVERDIR"/*.mod; do
> -	sed -n -e '3{s/ /\n/g;/^$/!p;}' "$mod"
> -done | sort -u |
> -while read sym; do
> -	echo "#define __KSYM_${sym} 1"
> -done >> "$new_ksyms_file"
> +sed 's/ko$/mod/' modules.order |
> +xargs -r -n1 sed -n -e '3{s/ /\n/g;/^$/!p;}' |
> +sort -u |
> +sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"

Did you consider the case when CONFIG_MODULES=y but no modules are 
selected? Also -r to xargs is a GNU extension and there were some 
efforts to remove theur use in the past (no idea if this is still a 
concern).

Other than that, looks good to me.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
