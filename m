Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4890C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB1C2184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562095947;
	bh=fXosmfpjpY4MQX0g3OzelQf3u9rAMaI1DU2AohGiWpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Klb1pOIEYsT01lGydSPkXCfn3s50FqdT3tVgPopuK5yENgzZruOzIM5kWCD/JrJaZ
	 XdqNNHy/iD6WV5cUB14kSbTqSMvc0qwN0F1KFZMpCauI4iJ7RzbcxLA6HNRC1R3DhF
	 dNENEwq/7XZlRGG5ufrmpqdtjF+owCdMAvKRPAWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGBTc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:32:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43609 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:32:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so8170141pgv.10;
        Tue, 02 Jul 2019 12:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/l7tQXDVVs21mlFttWTKF5GQ9EhRP7J1hjh79A4b/Lg=;
        b=iID4vGin5rQQbD+cClMm5N4VlFD4pYbHnKJLXuVQP6KTQIEA2Jrja2CZkorOtg5Rfb
         j1OFL8X9GTL7Wub+pdSJAUc/LMyZFuZyXNqjKtcmvn2kkccgh1VHKQCjGK1ka99UYMfx
         0AaTpaHmXfPl3/sFWKwpLANDXsZSIKyeo/32bAqUG5G3c2VehiGXsiHcm9Yh4NaGBD/G
         5UlGt1e+mR5hlto29Hr2xzYRTTaIUm9H0da4Aew3Y6d2oF+FR71mJggtlzL3GMpxrdzV
         8KF6Xyj8Y16MxU7ihs0OlzJQUpqK+uHaTryLSagr6OGEuzzqggZMT6dN0dISP7WdCR21
         RGrg==
X-Gm-Message-State: APjAAAVKwZgx2Bf7adUHNnXv+AR9/cL+ItAXHjwQjV85UNBu9XY6ObTm
        RzQQ/xxvI/iGdbe1BAUw36o=
X-Google-Smtp-Source: APXvYqzoUS5zJ+xTX5NbkJdjVUZSxiNHQHVsO8Ipj0tgdZzVFGsvMM8bgNOViPm05YgEuKg38RZy8g==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr7526225pjn.134.1562095945194;
        Tue, 02 Jul 2019 12:32:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v3sm14307182pfm.188.2019.07.02.12.32.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 12:32:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BEC0140251; Tue,  2 Jul 2019 19:32:22 +0000 (UTC)
Date:   Tue, 2 Jul 2019 19:32:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, pbonzini@redhat.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        mingfangsen@huawei.com, wangxiaogang3@huawei.com,
        "Zhoukang (A)" <zhoukang7@huawei.com>, netdev@vger.kernel.org
Subject: Re: [PATCH next] sysctl: add proc_dointvec_jiffies_minmax to limit
 the min/max write value
Message-ID: <20190702193222.GP19023@42.do-not-panic.com>
References: <032e024f-2b1b-a980-1b53-d903bc8db297@huawei.com>
 <3e421384-a9cb-e534-3370-953c56883516@huawei.com>
 <d5138655-41a8-0177-ae0d-c4674112bf56@huawei.com>
 <201905150945.C9D1F811F@keescook>
 <dd40ae3b-8e0a-2d55-d402-6f261a6c0e09@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd40ae3b-8e0a-2d55-d402-6f261a6c0e09@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:27:51PM +0800, Zhiqiang Liu wrote:
> > On Wed, May 15, 2019 at 10:53:55PM +0800, Zhiqiang Liu wrote:
> >>>> In proc_dointvec_jiffies func, the write value is only checked
> >>>> whether it is larger than INT_MAX. If the write value is less
> >>>> than zero, it can also be successfully writen in the data.
> > 
> > This appears to be "be design", but I see many "unsigned int" users
> > that might be tricked into giant values... (for example, see
> > net/netfilter/nf_conntrack_standalone.c)
> > 
> > Should proc_dointvec_jiffies() just be fixed to disallow negative values
> > entirely? Looking at the implementation, it seems to be very intentional
> > about accepting negative values.
> > 
> > However, when I looked through a handful of proc_dointvec_jiffies()
> > users, it looks like they're all expecting a positive value. Many in the
> > networking subsystem are, in fact, writing to unsigned long variables,
> > as I mentioned.
> > 
> I totally agree with you. And I also cannot find an scenario that expects
> negative values. Consideing the "negative" scenario may be exist, I add the
> proc_dointvec_jiffies_minmax like proc_dointvec_minmax.

If no negative values exist, and there is no real point to it, then just
rename the existing one and update the docs.

  Luis
