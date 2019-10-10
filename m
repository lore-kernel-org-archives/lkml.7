Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C52C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1AA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AfuUb30B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbfJJNow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:44:52 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42613 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbfJJNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:44:38 -0400
Received: by mail-ed1-f50.google.com with SMTP id y91so5499769ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoJ6TorxaA0ueOkAnVcY7UKvB59REF8/krI4QbdE3rY=;
        b=AfuUb30BN2fwLHvc++JsHy0F39WOPWyY6n5BemTQw4OffXIs9XPV8OEKc91w7W4+g5
         hrlPzv1yXu60ZCX+CWlLe8CNYfo2zJTFzNtQS/MD5/GwzPcnvFN3neUhaveUI3Q8qoVC
         VH1RNyOOxQ0acee6EjhlHOvgQbsStXwga5L2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hoJ6TorxaA0ueOkAnVcY7UKvB59REF8/krI4QbdE3rY=;
        b=OfCan/o3S26vRpDCeZWYvaOlOgs/pXi9KUryyHUSDw96XMkx8laB3gkBnGutQGiKzL
         HiaYBTyUjMHJIO7OYxrTRCUvm+Hl5toaGSGWbv1VIY0QjmeLUMyFDl7m8ZvSCBm/S01S
         rrYqVPOkbgFfTylcjPoQ3eHH1m4vd94eMzgLYApcm0S2adqrSD1pplsapBNu/ezZNyWg
         RFojUeih0OwXo2CEmq9obup7aIIogeV0ipzevweXPSHcAXvYAJoNHJepKxqGZj9XoUMf
         /8M+w7mlERL+h07YDDTzv4Ibtz0wgeeHQUWUkTmOOYuyXSPxQ6GljTXpmkunPG5zVH2v
         Kfdg==
X-Gm-Message-State: APjAAAV7DxdLyuZ1hthMCTYczVJ7W+PPfzMyDnH0nYJfYgD4ajPhBErl
        TDKzW8cjLV/VRJUfQBXgD64StQ==
X-Google-Smtp-Source: APXvYqzHiMfMRhzP+ce4ioVGwJmdp6neoxytw+JQPQJ8tg7kmLQo7v1y826ew96r7MuwZnWxO0ymAA==
X-Received: by 2002:a17:906:a986:: with SMTP id jr6mr7585993ejb.158.1570715076498;
        Thu, 10 Oct 2019 06:44:36 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r18sm974451edx.94.2019.10.10.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:44:35 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:44:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20191010134433.GY16989@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
References: <20191010131448.482da2b2@canb.auug.org.au>
 <20191010080207.GA22099@gmail.com>
 <20191010222210.1365d50b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010222210.1365d50b@canb.auug.org.au>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:23:21PM +1100, Stephen Rothwell wrote:
> Hi Ingo,
> 
> On Thu, 10 Oct 2019 10:02:07 +0200 Ingo Molnar <mingo@kernel.org> wrote:
> >
> > I suspect -next will have to carry this semantic merge conflict 
> > resolution until the DRM tree is merged upstream.
> 
> Yep, its not a real problem, I get a few like this every cycle.

Yeah totally within expectations when I acked that cleanup patch. We'll
probably have a few more lockdep annotation patches/changes that will
conflict in drm.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
