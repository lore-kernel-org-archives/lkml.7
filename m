Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9393B2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Favhxh+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfDWNdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:33:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfDWNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:33:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so20232204wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4k0E3WcrBaU7zCtDP8si1yICCPyuoyeseJHVw/RaBo=;
        b=Favhxh+zV1JK6eUK1ARmmSpe2hHCCkZxssT+5C6DF82o2BmUR3WlvjXF//qcLqfC+V
         hPlERw4oZevVoDdhac/FoEcIWL3KgVSNs3PXlCWkB1rRyyLN+IWGDwmMJZH9jyw+IY/B
         8Mfpigw4HE+zKbHcoSUxfbsmkZHWSOAPmr97KpjTFIA+eUcEWQ5kzECvhelz/OaUSxoC
         lQZF5AjFVJgXeCWrfg2rgWgkWnTbcQFqhA7+nE+gfNjchGUSDOTQ8rRR1Bpcoo8P8ljK
         Y2b/ZEkQrG9PPhb1+shzQTGm6c4D65aw4CDRTleTX9EibDqV8XOlUB9qg3UgY0AaJ9yT
         3T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4k0E3WcrBaU7zCtDP8si1yICCPyuoyeseJHVw/RaBo=;
        b=OhwTfdWuD9b7vXYX/eEZoe+1vchpkdc2usJskcdu+m7M4oPDsjFo7MbDLJkoMtDDPq
         oG9uqR+6sVoW6ueKr53655OhOn33hTt7yceqWCp++lZ9lbRIdI+dV1vOsprRYrJf4lkK
         RxgFunFlgcqJj4KFt0l84EeZESw42R8ROObaDXtDg+AHOijkLvgnKrJWXZOeA2LzVIS6
         avL6l8xbZ6fg6uM7OtKS37L27B1RSsOPPXMOlixsVEq88eg8Cu5IxAS83NWTyP7Ysgaf
         s37+GgODw6+3quXA3ycCmwJ/IWCLveaFKzsBJZ04rKf4dvteF33MO1nsrjet2n5fIDMV
         P+LA==
X-Gm-Message-State: APjAAAV1x6aC7Huuqj1O5OlcYkh9r/K3U6RZQTLzOosHUYygi5c+kS16
        qIx0KLuZSeo8GJgL2YuvDFi2Gw==
X-Google-Smtp-Source: APXvYqyzqIPNOuZGDqphJVQ6Hd8gmX2Dc8nG7YQBio16M4rr1P6Cx64lslaugIl4n4qdtT6DAeEkJg==
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr10995988wrp.305.1556026415611;
        Tue, 23 Apr 2019 06:33:35 -0700 (PDT)
Received: from brauner.io (v22018046084765073.goodsrv.de. [185.183.158.195])
        by smtp.gmail.com with ESMTPSA id u6sm29478703wrg.72.2019.04.23.06.33.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Apr 2019 06:33:34 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:33:32 +0200
From:   Christian Brauner <christian@brauner.io>
To:     weizhenliang <weizhenliang@huawei.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "colona@arista.com" <colona@arista.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190423133331.b726uqa33mad2jsi@brauner.io>
References: <AF4D908CC0E2A24EB308A26962C8C3BDEB16AE@DGGEMI530-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AF4D908CC0E2A24EB308A26962C8C3BDEB16AE@DGGEMI530-MBX.china.huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:10:52PM +0000, weizhenliang wrote:
> On Mon, Apr 22, 2019 at 11:25 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >On 04/22, Zhenliang Wei wrote:
> >>
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
> >>  	if (signal_group_exit(signal)) {
> >>  		ksig->info.si_signo = signr = SIGKILL;
> >>  		sigdelset(&current->pending.signal, SIGKILL);
> >> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
> >>  		recalc_sigpending();
> >>  		goto fatal;
> >>  	}
> >
> >Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Last time Oleg suggested using SIG_DFL as the third parameter, but its type is 'void (*)(int)', but not expected 'struct k_sigaction *'.

Sigh, I should've caught that in the first commit.
Although it suggests you didn't even compile your patch...

> 
> How about
> 	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, &sighand->action[signr - 1]);
> ?

That should work, yes.

Christian
