Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCEFECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D02190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570791036;
	bh=L5GA3IRvqoq9EldM3N4QA0bgmAK6vCdTcJviM2ntIeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQKRAacuSLQXPunKgFbLWl2wOiisoQRgvyiqSOvW3dU6YjcOvQ/zWXDOrFEHJ4H4V
	 IVLb2JvpcL74oBsTLWryeDAp18SSCoztjMzoowb3MS+Hdn48nrVH8HWmut1A+R7yZY
	 EAvfV6+kuYrSIuJPz22N6S/yWDgfHOh6QpazJ4a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfJKKuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:50:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37088 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:50:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so11373611wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UvBObGs24ppq9+dm8IY3Q9jkyhFjMei+3Zo/di/pUQM=;
        b=d//8cxIagooDlSGw8dT7yc3zbGRQhk/RehIU1YPibmqgc2c1n9tw+ovrtWmQeTUtqP
         tXqw8+AwoaR58/KnHk9YAqG6EysLCF1XoWB4sW4PyXkFV0A5JiizLsRCSYMlVTsAse+T
         m0x5qqVAAeN46YXc6BqMlVLco+LsVf4jPUIMO4wmSe4yXS8ETFE28jwv2DrpWUrBzFAx
         DhcvFAsfNrB9P6bRIW26mGK5loYFmAodG3N/p7PURpbVkdFmOEODhPsO8rWhx8JE8IsR
         5/MflwDFPB8o37GO763ATWTi/kD6ciryRaNicSh4FcBfgjR23nPiLSe3R9aJMzEP2o0+
         OwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UvBObGs24ppq9+dm8IY3Q9jkyhFjMei+3Zo/di/pUQM=;
        b=KiG6fagpee+lmx9i9EwiQG6NnJ/uM/klmJ9e/bgvTiTnyIDhg68xjmR1HBfAn5bOtc
         MlxhawHgX1utiNAhCPBoDaEDFY03AYN4r9Y3ilCg94bfY02XDaRoAXlXAZUTO44+vQd0
         wJ5Ian2AWvfYVIgZRe6VX7VIbyqWZtad6z2jLy5w+JAMwtfDvVmZupe9e96g2XgeoiEX
         3qCD78UnoQTDj1ZAbBfT63Wl1Qru325zzL4RxqEq3WtGSSiAp0ZFktuDa0a43XjSw1I5
         PtUj0LlTCB6WyDQfgKA20DqsG5IxvNc78ajba4rZst+uHKuc2WPo4HVo9My9P5W5W+nZ
         UfGg==
X-Gm-Message-State: APjAAAXZ07VO5Zp8A6q/nbxsXJYzmXzI54MUDVMg/JRsrGiFaXT7F62+
        Ku2RcJYjuXe3RqzTGhuSgjQ=
X-Google-Smtp-Source: APXvYqzGbmV50U7hM6zfU1kYVjk15MREcXJcbJp8vnDpqX7AnjvbT9+lVoiF+ByKsF8iZLWpuLgpyA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr12232167wru.366.1570791033119;
        Fri, 11 Oct 2019 03:50:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a3sm7975586wmj.35.2019.10.11.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 03:50:32 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:50:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 0/5] x86: fix syscall function type mismatches
Message-ID: <20191011105030.GA37952@gmail.com>
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20191008224049.115427-1-samitolvanen@google.com>
 <CALCETrUAQ0of6bViOCmSu6qyoswTL+ThPOo3++9v_f-ek4CtEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUAQ0of6bViOCmSu6qyoswTL+ThPOo3++9v_f-ek4CtEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, Oct 8, 2019 at 3:41 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This patch set changes x86 syscall wrappers and related functions to
> > use function types that match sys_call_ptr_t. This fixes indirect call
> > mismatches with Control-Flow Integrity (CFI) checking.
> 
> tglx, I'm pretty happy with this series.  Do you need anything else
> from me or do you want to just pick it up in -tip?

Thomas is on vacation - I've picked up the series, it looks good!
I've added your Acked-by to the #3,#4,#5 patches as well.

Thanks,

	Ingo
