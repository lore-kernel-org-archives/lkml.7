Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853AC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5417F20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TQXKisb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLIUbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:31:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40822 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLIUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:31:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so17193106ljs.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtSnkh/bQ3nRcwbPWyDEoC5sS6sTfNQ61n5WXag4RSg=;
        b=TQXKisb/u+nCZaUFIHZbt6vrBToHvsyyouYG83bL9aHsrrjtRvdZJwM/ghFdOcNL0l
         7PwEsI2aN6kU6bd43IEAstkXa6YHlDXIOgcVERCOMQHucxZJOQ9BK7Fsx2wuivc2+4VI
         pYS+1LsVVnCQXPWL+2Y77ddGR7l38DTZ2RwKIFM9qvspawn4aM+iNu57Ek/PcDFJQ3Eb
         itaCwV988R+Rnfy/GmZbzGIelc409+ljtTRAXZXdKrMuauXcKavAsJC/j6Lkr+MlexwH
         XOFXIlLPFh+hANyweaeumsdP/KP5yvaPutyihrpesAZJJx8D5KVix6iJSHodZCcXXw40
         NbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtSnkh/bQ3nRcwbPWyDEoC5sS6sTfNQ61n5WXag4RSg=;
        b=tXNeBZ489OnfZ9ZCuf4jhbJ89hdICUQQDzLt8um25kN5utuunHvPsRCvBFz+5CSsew
         +jNTW4hKrycrsbneZDft/rHBS04/T0f4a7oBSbql5e6p4Yp5N7GuWbQTXN/VZpxtF3Ea
         fmf4EtzrhSui8OLQCP/qTkx4Q0OFjdgj5FZz689ZaVxTBtXhkhv5innBjNblTVo4tSzp
         DL8aXqyBwtDML4omQjKlooyke+vawNWcAHUBArDW5hJzpgmSBnV6LwC1M2W3JMQ63WmY
         +aLKdZiJyjGkD9KRQcEoZW12hpDc1OLlv5ycKmZ4sSsAf4J6JAmYjZxXAmc/WsUsw8Ag
         Wk/Q==
X-Gm-Message-State: APjAAAXFTM5csPwPBFsu7r/n98kKWSkR1clr1EltSbk+7Mwk98ssGXpK
        2byl2BNEyp384eZve/CgrskRmnWk/XFDuUBDUpDQ
X-Google-Smtp-Source: APXvYqwNuaM3T1RoYDtFsytt5qY7kCFzvkm2V35m9l8RLEbT2lVNz1KT7NTjE2alakRLWdNQcQZBGT6GCrkypO1NLyE=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr686698ljj.225.1575923480292;
 Mon, 09 Dec 2019 12:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20191201183347.18122-1-frextrite@gmail.com> <20191202211915.GF17234@google.com>
 <CAHC9VhTTS43aKQojtoBRRipP7TwhaVnK7DAqpFN0J0_FNLY+sw@mail.gmail.com> <20191202233458.GN17234@google.com>
In-Reply-To: <20191202233458.GN17234@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 15:31:09 -0500
Message-ID: <CAHC9VhSLM=MBXEXiwG+in1+WrTvVpSJxm+eYH51xRfMkoCafBA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel: audit.c: Add __rcu annotation to RCU pointer
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, rostedt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 6:35 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Dec 02, 2019 at 06:24:29PM -0500, Paul Moore wrote:
> > On Mon, Dec 2, 2019 at 4:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > Good idea to CC the following on RCU patches:
> > > Paul McKenney
> > > Steven Rostedt
> > > (Any others on the RCU maintainers list).
> > > And, the list: rcu@vger.kernel.org
> > >
> > > Could anyone Ack the patch? Looks safe and straight forward.
> >
> > FWIW, this looks reasonable to me, but I don't see this as a critical
> > fix that needs to go in during the merge window.  Unless I see any
> > objections, I'll plan on merging this into audit/next once the merge
> > window closes.
>
> Sounds good, thanks!

FYI, it's in audit/next now.  Thanks again.

-- 
paul moore
www.paul-moore.com
