Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44932C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2D20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jndXadi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfE1EWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:22:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43014 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfE1EWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:22:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so10626741pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DeVRVtvo+X+I5ImBe9C0dDj60lKHwgi7pzEoydA8Ywo=;
        b=jndXadi6lbC6yEcMoPo7/WKVH5GT3Lyf8QI2tyNA91LFhgb1IeHDGL8AqMDpz7QsfB
         u+xslzdn68hnaPo1Lkx6MSeX2znNX2/loejw+b/rV+ggVgXwfTVHgeh0tpEyqsdNtpoB
         DnaGhNd0cLZnVmgu/tpQq6vIyKXP2LyqL2IPyWhnoOSvphn7Ay0skojq2+zqXm7uZChG
         W1LpgOsIqlfnDehjbi5u/CjvENhcthO43JgcaoU7uN+hXbarJ7gm61tcRyPkLw4gcHDI
         PwYY5afu9oqQGMQ4BuSM056EQ7vnVQTf0Otfxhe4iogzkRNVIKtc0pwddga9KBTIH4JO
         URsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DeVRVtvo+X+I5ImBe9C0dDj60lKHwgi7pzEoydA8Ywo=;
        b=LfTLVg6sz7vh1OXchwreYaF3fYV8QQnCy7w8ehsis8HlefSqVU42z7SBvrQAiQLVyw
         KoRI4WPCghBRWKBi1Y7Oe90CKq6QAYsSpXkFSKs056Fk0hLNCvaLyYB7SB6M08tp7F7c
         OnyVLqCdDOyQ5fFZgygJd2GPuhxzsWS0EfKRKzY4AjfW3t8q9VaCwY9438ctjeRhE5F+
         NKBhNkUixoMv4ROhZYX6c35SolYSKIB5O+mR7CoJZcYDdRZXyLh9TY+f9VvxTDYJGURo
         zDRzqAyooOp3EZbva80VFWFlmLNgjAAlp+LWNf5E2D2HcyGdsO/qefy1AqT1U6RJmTw6
         nTOw==
X-Gm-Message-State: APjAAAW/ZScQ0ln96/mtAg97mmcvr9h/cXaIbfkQq/XXB0fpHvlGqRDQ
        lb1SIfSeexG6CwP1kEmhVEU=
X-Google-Smtp-Source: APXvYqyph2kqOR+gIGTJcCfaIpzZiAm3HxP8jb+36XA5eaesu5+21KNsO8z7E/qX5xRPC/5Y98JuDg==
X-Received: by 2002:aa7:8c10:: with SMTP id c16mr93515095pfd.89.1559017333050;
        Mon, 27 May 2019 21:22:13 -0700 (PDT)
Received: from localhost ([175.223.45.124])
        by smtp.gmail.com with ESMTPSA id z9sm11584620pgc.82.2019.05.27.21.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 21:22:12 -0700 (PDT)
Date:   Tue, 28 May 2019 13:22:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528042208.GD26865@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/28/19 12:21), Tetsuo Handa wrote:
[..]
> What I suggested in my proposal ("printk: Introduce "store now but print later" prefix." at
> https://lore.kernel.org/lkml/1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/T/#u )
> is "whether the caller wants to defer printing to consoles regarding
> this printk() call". And your suggestion is "whether the caller wants
> to apply ignore_loglevel regarding this printk() call".

I'm not sure about "store now but print later" here. What Dmitry is
talking about:

     bump console_loglevel on *this* particular CPU only,
     not system-wide.
     /* Which is implemented in a form of - all messages from this-CPU
      * only should be printed regardless the loglevel, the rest should
      * pass the usual suppress_message_printing() check. */

	-ss
