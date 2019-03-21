Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598521874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192355;
	bh=qrn9WlnahAiB++hZpQegMOCEejvUTf+ltmPBNYEB17k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bnntUJXvalffoBhZk7PzhxR7NbKmE76MfFGAfffGvsy5b8uI6TzG1ZvhFdSpSkep4
	 kkGZkbeg9I3GQuqxJeBJ1kdA6GIlsHrI9ZV89Ob0CjU3HAfRWuevtc0T9xsnmUcN1n
	 iF6VwweWmrLzEZaLu9XoBtsmFBwhS4JWSLfVtDTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfCUSTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:19:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbfCUSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:19:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id r25so1706953lfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZotGGbR6yKUxolSVIlwFT+5L+D2RvzwYtgbxe+84DY=;
        b=AOPzLDXyE7w8u7Cy2G0FYuMj890Yl8kIy7jBQtaiayt5QYtmXv8Ul0U7TGDFFhP9Ex
         AmtYVorXJ6m428x7t8q9PwwtdTTw6jlTfodumBLqZO0KrM2pdkYnd+faxDarSYc9GJcO
         LO0YTdbE5SaLXpOEUptqD20r02uEYraaovBs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZotGGbR6yKUxolSVIlwFT+5L+D2RvzwYtgbxe+84DY=;
        b=SMrWkd/drAl95oRaCnge5IO8D5/2eXtWKh3a0+f0LrtzDusjeZbZi60c0trVN0i48v
         2eYo27F2qbAry0NPMA42+C4hntBnTIO2pK6PSo8jpTtFsQVkKpoECNO7Pir32LPIbbfw
         TeeSwskAV6qG1/XUwq3nDkgIIQQ+tGIs+qA07dZy0aUebAcHiawVSEFTpp0dJN/QnhWa
         5jofjRBnWHckKITqQje9zGMhaVTq+pomYg7Lkkw6UIF+OqjG1W7Q9otaoc7U2xZY9xwc
         IpnCR/UU6ae+8zkuR7TVJOvdRYrGVFLAYyNSOFgIcAXFDKRWPs170CawYcbE0tnlVEpW
         9UDQ==
X-Gm-Message-State: APjAAAWw/Hvou4jEcmgDrEHt3QskewYuy9FJpO9NQha/WdrQ2SSkY4Hb
        80G/b2lg4AKWPsDawVJ7EuApvXJzqSc=
X-Google-Smtp-Source: APXvYqzTNXD9Qh46eM0T45FBkZH9WfC7h0CtCfhIu9Xy2yTlHVU8fDS3OcdSb5Mq2TV6dCIUQpjSBg==
X-Received: by 2002:ac2:514a:: with SMTP id q10mr2757788lfd.17.1553192350610;
        Thu, 21 Mar 2019 11:19:10 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u18sm1096653lfd.15.2019.03.21.11.19.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:19:09 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a6so5301110lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:19:09 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr2768854lfl.148.1553192349132;
 Thu, 21 Mar 2019 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
In-Reply-To: <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Mar 2019 11:18:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
Message-ID: <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:05 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> In the long run, I think the right solution is to rewrite even more of
> this mess in C.  We really ought to be able to put the IRQ flag
> tracing and the context tracking into C code.

Tangentially about this long run thing - can we start discussing just
dropping PV mode entirely in the long run? Or even not-so-long run?

What are the pressing advantages of paravirt these days? Because I can
point to a lot of pressing _disadvantages_, and not all of them are
about more complex code as shown by this patch...

             Linus
