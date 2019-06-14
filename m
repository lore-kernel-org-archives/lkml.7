Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB12C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FF32173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560526725;
	bh=s+Zwd+ONqT1pksANmhQFeU8cIb2gGorOOp+WywyUETo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pZxbYXfrHnf9krx/MM9AndcrPigsnwGOEQAX6a1Sgjkjig+KrkjZzpZ+kVA7xTvf0
	 xl4MVT80weuvbmEPzoef3ZrXMlGLEzf1Lc0KdqsllawC41A/iOLKDlcVha7160mQgD
	 WJ80CaN1TM3Pw6vG6hPwTcLqbTtJzWvltd3haVcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfFNPio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:38:44 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44859 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:38:43 -0400
Received: by mail-pl1-f178.google.com with SMTP id t7so1167139plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KRgtgULPK891tOGG5t4dUW4/Zs8Jf3twwJrLAvaHXCM=;
        b=o3Lri5DsGsWuggMDg29Bi3ENUTlvH+3GmvfvzTZGh2sF3pkpez5DNm8bBAnAUaEWZZ
         3c1JTmWV/+H4DwAEWKuf8SIhFlrkKgyxGA08WQUxcLuuBDucCsPpX5ou261vea4IAUD4
         WQYvESfcDZvmL6S+6IRwxsPQuEsCTmLfTKe3hQlII+Ia2XdlgWmUu3rLDCHGq83/HVlt
         NK28IS/TYC5hON8cjCk4En/YfFspE72vU+HJ/iEGlOPHFGTMVicpAIpXo9xI/uzf5A0u
         364X1XL7JKHiGgzJ2Q9GwBwCLBz0Bd91qQovHCccul8GepD3nt7DLEeGJOYTE9baEEe6
         mZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KRgtgULPK891tOGG5t4dUW4/Zs8Jf3twwJrLAvaHXCM=;
        b=O4W0D3GqNkEl1OFZs+XHpQS6yIj8voVI1k4UapHWIh3EIO4zZSeou1ftqtcsT/LzmO
         b3GdRuE8X7vwSrHQrpvEgoTz5p4C7+21cFYrfFaVzkVXIZcryNqaMen4W6F5FCOygzE0
         lN2309TLvvDLeEfcpLii58s6FBIAVt5PzaOaEMjyhm5ZtHV8i5XzrUw7zeW/K0toKQLH
         UZPCujTj863ZzgXEWU6he4C/ht2sH5qJlUDB+OETThrsyQXP93lgulnolUyUK+X/3Lcw
         YBR3yHY7lpY/QC7XcLYHUjirZDHX+Stt9KrbL3t6TzSqvpRHfacO3tr39NwwJIVn4Tky
         Y73Q==
X-Gm-Message-State: APjAAAUuhY7UvSGHTCc9mh3Yth6RZg0y3b3NQaRot9K17/3LTyy0xBN+
        BqC9txORpeG/pYx9N2bUtc8=
X-Google-Smtp-Source: APXvYqwiq+8hGeYQ6L6Er98x3qaWhr3zME6PrQeoyZkRUO5Spda7XFFJhNph3wuEpCh6CNK8gyW1Eg==
X-Received: by 2002:a17:902:b705:: with SMTP id d5mr57674507pls.274.1560526722616;
        Fri, 14 Jun 2019 08:38:42 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:b330])
        by smtp.gmail.com with ESMTPSA id w36sm7563630pgl.62.2019.06.14.08.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 08:38:41 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:38:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [BUG] lockdep splat with kernfs lockdep annotations and slab
 mutex from drm patch??
Message-ID: <20190614153837.GE538958@devbig004.ftw2.facebook.com>
References: <20190614093914.58f41d8f@gandalf.local.home>
 <156052491337.7796.17642747687124632554@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156052491337.7796.17642747687124632554@skylake-alporthouse-com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 14, 2019 at 04:08:33PM +0100, Chris Wilson wrote:
> #ifdef CONFIG_MEMCG
>         if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
>                 struct kmem_cache *c;
> 
>                 mutex_lock(&slab_mutex);
> 
> so it happens to hit the error + FULL case with the additional slabcaches?
> 
> Anyway, according to lockdep, it is dangerous to use the slab_mutex inside
> slab_attr_store().

Didn't really look into the code but it looks like slab_mutex is held
while trying to remove sysfs files.  sysfs file removal flushes
on-going accesses, so if a file operation then tries to grab a mutex
which is held during removal, it leads to a deadlock.

Thanks.

-- 
tejun
