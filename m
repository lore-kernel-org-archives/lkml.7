Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFE621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552664876;
	bh=TbYzODbXfxV0ga7bs7I3xFjsxqoiCyvzDFDz+5RF6KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rJJduib8eX4qOERVrFCuOi42CO6psWFDnTnnjxtDVCOdb4qI5AjyHgfo1poksh5MV
	 BxttlRx7DjBPcoNc2YcAN2WJcT0qK/IVrZkORbnh4oekH0IBveRdrRDb57Vo4il5U1
	 Vm32Cr7FJ/bjFRhfhkjs8hBWopWWN6x8UXL5YXss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfCOPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:47:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42369 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCOPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:47:53 -0400
Received: by mail-yw1-f68.google.com with SMTP id e76so7603878ywa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toHu9kiGB504MlX/pYUW3ZiVDLdNJnCMuFCUpttf+Cc=;
        b=df3VcRvtyVWA6kKsgkrakmP8Fmnrmn6kjIC6ev8joHwaKHQahex9DLZrN5HnWIVK2F
         mpQncZ+cTttGxmbwhWbdJlH1It525sI+9vFyaBtJN0rxA/IQkXIussT/lIjpqeysY8Ca
         nSjNOMU0diZ0ylMjP47uWmlWEooOLjVyaYZS1v3cto4Ilp7jEcvF+mJ/edasL7mPc84t
         R0QbzPPjfgqPofs6yqhOpFgGTnJl4sr5W6f5F6qMKCiatUcDdlvRGUR9KrlM98Tia4PW
         Ib8n24A0czBt4n2w1YlewpUrKp6r9BOJ2gtFs+1hlp9/ozOdEkxD5AtyxN56//gfFkeP
         zbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=toHu9kiGB504MlX/pYUW3ZiVDLdNJnCMuFCUpttf+Cc=;
        b=WwnrnJ1bcNxdU812Wcki5+a4wSxfeQs8ibGB+XvE4PAySuo5wvWK4pL/O9Uc0exwqI
         SqRlXMP8d/mbGLJAtWX0MjNIzch1pyXE79EwyC2Y7xBVQqYeRe5SPhTcwshYw7ZISsKX
         SlIPPkpXi0crtsL57RaBiKDYDoB+9QnMHWFF8GhW/KO2i3S78RfzgXvM72/BeB6bxrQG
         vbrYFih6a3baOtrBFAV7gZ8c33P2IZ+EuUNZKxG0nqDWTrfgYP8d181xH9pM5LGt9/4b
         Y3sSxd2pu27TvNlhu25K3GIiEXzZgCGuOQ2Vii1mVAuGo3l/OkkhQNKEY8prst7+JJSC
         ui5Q==
X-Gm-Message-State: APjAAAVRh0YeCIl53aBKFTtInnYL3HlAduXpjbElaaMoGSEUG/Xbvzfg
        AyV53+6Zr7PDI1rDRFP7Zko=
X-Google-Smtp-Source: APXvYqxZHYhxv9Fp9qaezwdtiwV3FBRL861GuB3mX0pTCGsk5iZ19rkU+Csgzs11ysa7gymqaCKW5w==
X-Received: by 2002:a25:9701:: with SMTP id d1mr3534773ybo.125.1552664872754;
        Fri, 15 Mar 2019 08:47:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:5c56])
        by smtp.gmail.com with ESMTPSA id p7sm115174ywl.17.2019.03.15.08.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 08:47:51 -0700 (PDT)
Date:   Fri, 15 Mar 2019 08:47:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/workqueue: Use __printf markup to silence
 compiler in function 'alloc_workqueue'
Message-ID: <20190315154749.GM50184@devbig004.ftw2.facebook.com>
References: <20190312202126.29868-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312202126.29868-1-malat@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:21:26PM +0100, Mathieu Malaterre wrote:
> Silence warnings (triggered at W=1) by adding relevant __printf attributes.
> 
>   kernel/workqueue.c:4249:2: warning: function 'alloc_workqueue' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to wq/for-5.2.

Thanks.

-- 
tejun
