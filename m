Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96118C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A84B21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Z8MtYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbfKEQUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:20:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbfKEQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:20:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so15906638pfb.0;
        Tue, 05 Nov 2019 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPVzr1zF8FoSavwzywDNDMaLZfpRZ21grLGFJWRaQIU=;
        b=Z2Z8MtYGi373NNAWDZz42HeMuGe7BEJkMfI30Qyj50jQnSlcVYc85z4f4nH35KIcru
         pFYdzrPtkPxWJaIeXkHw3mhsE/OLQSxoZglyhJDnmpZn7/e0OeIqCItP1vDMu5LY02hD
         O8Ip8VY7PnkU9Ng0mb/VQl/+vzlPrAsaEMCrvVEf7YQ2k8rs0XYkEfBd2g9frV8GrmWR
         gHC0yGQ0H58nS/5AB5+QnzwWZst5eY5+8whiffDUVTASowbRXKWalL11eiUUNojm+XCe
         85qU152zCeNNi/J/AIaBFW7vL9ZEoMkJ1uBEgNu+j4mZEoLZLZxVev0j/Jlb9/7We7MK
         Ckuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPVzr1zF8FoSavwzywDNDMaLZfpRZ21grLGFJWRaQIU=;
        b=Vj8L02A1McMsNW5pr2nuqAnz5pfM0NZIdvU/L5BDPx42jN/NhAayGdBj24/aC523GH
         4zfmbnYTmdAe6eYH++W0qqnmOyFIWGE5Gke199Woaj/rPsXIoyUoHmpLFoSRGIotTEhA
         YGVfCTX4OtOmo79OzW72mXI9mtpO7Xx5l/eNrAMRH0rTHIRSyrz9HxCGR5Vev+vivBix
         ImmWnRyb40A2Ey7EAu3dM9uLKzp6roKAKHIeiDBGfPJZRAd/n36qmjqZc3n9r6eiWSOB
         UJxvF3eAVVPjSjUwQicg09Ex1EGVdUVgsGdpV4pwAw86/DjXfheQSf3epWkaC7Lc7Hqx
         bqVg==
X-Gm-Message-State: APjAAAXp6PGh7frt1Olm92VPxpuZAf+W4NMiliMRfFpAxNkp+wSLt2rE
        JxWp0xdL9kKYv7mFp2vSXqg=
X-Google-Smtp-Source: APXvYqyFwAsiCDt6AGENcB7yeqqnr/v5aOegQz2usIGj2+tHe7XeVZpvQBweyYpsJ6cneMn6zCf/zw==
X-Received: by 2002:a63:f94f:: with SMTP id q15mr17430362pgk.412.1572970841275;
        Tue, 05 Nov 2019 08:20:41 -0800 (PST)
Received: from workstation ([139.5.253.184])
        by smtp.gmail.com with ESMTPSA id f2sm17765272pfg.48.2019.11.05.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 08:20:39 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:50:32 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: RCU: whatisRCU: Fix formatting for
 section 2
Message-ID: <20191105162032.GA10619@workstation>
References: <20191104133315.GA14499@workstation-kernel-dev>
 <20191104150328.GZ20975@paulmck-ThinkPad-P72>
 <20191104171641.GA15217@workstation-kernel-dev>
 <20191104194528.GJ20975@paulmck-ThinkPad-P72>
 <dc5570d4-26bf-59ab-76bb-79490dde2369@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5570d4-26bf-59ab-76bb-79490dde2369@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 07:52:59AM -0700, Shuah Khan wrote:
> Hi Amol,
> 
> On 11/4/19 12:45 PM, Paul E. McKenney wrote:
> > On Mon, Nov 04, 2019 at 10:46:41PM +0530, Amol Grover wrote:
> > > On Mon, Nov 04, 2019 at 07:03:28AM -0800, Paul E. McKenney wrote:
> > > > On Mon, Nov 04, 2019 at 07:03:15PM +0530, Amol Grover wrote:
> > > > > Convert RCU API method text to sub-headings and
> > > > > add hyperlink and superscript to 2 literary notes
> > > > > under rcu_dereference() section
> > > > > 
> > > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > > 
> > > > Good stuff, but Phong Tran beat you to it.  If you are suggesting
> > > > changes to that patch, please send a reply to her email, which
> > > > may be found here:
> > > > 
> 
> Please do a review and send comments and suggestions in an email
> instead of a patch.

Hi Shuah,

Sure thing! I'll do a review and send in the suggestions.

> 
> > > > https://lore.kernel.org/lkml/20191030233128.14997-1-tranmanphong@gmail.com/
> > > > 
> > > > There are several options for replying to this email listed at the
> > > > bottom of that web page.
> > > 
> > > Thank you Paul! And that is correct, I was suggesting changes to
> > > that patch. However, since that patch was already integrated into
> > > the `dev` branch, I mistakenly believed this patch could be sent
> > > independently. Sorry for the trouble, I'll re-send the patch the
> > > correct way.
> > 
> 
> Please drop your patch and do a review for the patch as suggested by
> Paul. This should have been a review and not a patch on top.

Noted. Will definitely keep this in mind the next time.

Thank you
Amol

> 
> thanks,
> -- Shuah
