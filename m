Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01100C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C99218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576596208;
	bh=j1i+bKKaHw/tRUgDFaG5InWe1pLJezTHcYPQMLqGt3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Zom302M1oLXcCM5s8z6A9bPsNtfHWoLgXLxjinWLKC0kMmoDM8t7xnTjs0nS7ARl
	 ny+36BX4UhCPY5dnZbyxPuIki2L59yUPw/SuHawIRUiU7kX9A6i1n4U4a9/wm+0Ecx
	 yuqNz90Pbb1s7FnGA+3As+WGEEUgv4ideMvWueAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfLQPXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:23:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfLQPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:23:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so3613329wmc.3;
        Tue, 17 Dec 2019 07:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8BDIpO9Zy1hRZoBINSyR5TXnQqjD5E22aWmsf8ruxo=;
        b=UGTXGKzYVc92j9svo2QPONDpjxKYdC+YMbRjWlp6OQ+pbSTxgMQ6Hb2XoibEcy/KNV
         YUn++t4ETC2w5ufGVLe0FgyCycb2BW4FVucz1tz/qlRAgb/U5W8jJXnToWSArUsifzp8
         WN5SOk0CMvBXVOKkR7lWzasZhCXXwWz7l+9FpZhuwlyopUsTFFEpCcvxfzhK1xNJ0HDp
         smaEiJH4lVW9bCSWK1Fh9+Ipdxmoda+F23lGj/i652rhAMaW+AneVr4jwuviJZwwH7zG
         PqaMK4UoofRY1BLjreTX/053ttHcaWBbi+YEA2Fe+LC+lYzeLg/ZFV0Zut3bfBod6R4y
         t1aw==
X-Gm-Message-State: APjAAAUU94TS7NWQQq5LrYMLROdaPjJnrdp+6fnSCLwCk6NJh3HdpUkq
        gwoq9Gav0dAG0jh43g8Sho8=
X-Google-Smtp-Source: APXvYqxykdupmaaJlCGhZTu9d3ZjUfBJpeEMVH/5yMAA143BPmfWgEIabGlr18MOEXLHNQaeKr3mGA==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr6042189wmc.174.1576596197992;
        Tue, 17 Dec 2019 07:23:17 -0800 (PST)
Received: from debian (38.163.200.146.dyn.plus.net. [146.200.163.38])
        by smtp.gmail.com with ESMTPSA id w13sm25989787wru.38.2019.12.17.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:23:17 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:23:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/3] xen-netback: switch state to InitWait at
 the end of netback_probe()...
Message-ID: <20191217152315.gxsi4idfxnmloe6u@debian>
References: <20191217133218.27085-1-pdurrant@amazon.com>
 <20191217133218.27085-3-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217133218.27085-3-pdurrant@amazon.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:32:17PM +0000, Paul Durrant wrote:
> ...as the comment above the function states.
> 
> The switch to Initialising at the start of the function is somewhat bogus
> as the toolstack will have set that initial state anyway. To behave
> correctly, a backend should switch to InitWait once it has set up all
> xenstore values that may be required by a initialising frontend. This
> patch calls backend_switch_state() to make the transition at the
> appropriate point.
> 
> NOTE: backend_switch_state() ignores errors from xenbus_switch_state()
>       and so this patch removes an error path from netback_probe(). This
>       means a failure to change state at this stage (in the absence of
>       other failures) will leave the device instantiated. This is highly
>       unlikley to happen as a failure to change state would indicate a
>       failure to write to xenstore, and that will trigger other error
>       paths. Also, a 'stuck' device can still be cleaned up using 'unbind'
>       in any case.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
