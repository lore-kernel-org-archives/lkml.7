Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8083206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553622548;
	bh=f2NcPQ19rDTOM6CVtELOABOANqs5x0N35OlcrzjCcpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YhJkdm7SD8MMthRkBIVP4dT5l8iVbzd0U71YbyOrJLJufUmK1yZPN5uyd5a6R3GZZ
	 g0MR+whxMsq5ZHutrnIIVatHmj9mPkrWXej1GUZGaJiB4HCPRdGcFZHrV96egzkDXy
	 +eoYL5ea63famsgtnGEiE6lMozHaTFCKbaudB1J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfCZRtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44200 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZRtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so7461220ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfoKLk2+9/KvnloA+uSJnUZ3mfBGUKvW3IDXIyogc3g=;
        b=Io+m3DQ8fFw8QJlkwNbOGG23/NEeL/ahE/i+aGZvImb6I262hg7I/+xZasJuag8g46
         MgP+bzVMAOnYLdTmsYogaXNPGD4CgwgbInnt/JTK9Fg8fXkeTMwfgSXqaA9tTTcYm0Cz
         8wbYXw7EfiVbac5IwwcBhMSmcLCqLj1b6WBv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfoKLk2+9/KvnloA+uSJnUZ3mfBGUKvW3IDXIyogc3g=;
        b=F5aYtfV8Ds1GnKYAqu7FHN6gSoxYq3U1FX7stiXN68yk5E4a+WuWkzDCr8H37mLJso
         g9PV5GcsruyOyOLRq7DMei8kLORv/wBcasI9GtSZf36yHFRttWC0ZVSU4WdV56ZJ/pEv
         MCRmpUUnfaP128oYuEtUb4nB5BOI6UJgYAx3QXjanahzMd9ClItBA8cs+c05YCozdQq2
         Ys/oKkTGWacSfozjd763v6OfgsSLbwaKkSU5QQ8c3un8utEYVZDH22UGCtLvvYKTQjh8
         fR95BKEPbKV9Po/AWkaTgjaqHJ6PupGSbPdzI+HoXkgsn8FRqwBVTcLt8WkUtkGAlECh
         PaLA==
X-Gm-Message-State: APjAAAV/A3xj+16h0Zk2g0trnynoDrYjCUpHyhOjYh3+UqFJj2QhdJ9C
        BL4ui7q2dNLqpfchyeIgTXMKCwtsRDs=
X-Google-Smtp-Source: APXvYqyxwB/t11vMSZbJYvrDvpSwc63qYdRy9KD0dtVbEExbGgGy5ZQLT96Nji4S2TcCpOvPE3VO2Q==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr5931419ljg.189.1553622541088;
        Tue, 26 Mar 2019 10:49:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e3sm4149079lfn.80.2019.03.26.10.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:49:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id k23so2607298lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:49:00 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr17449317lje.22.1553622539889;
 Tue, 26 Mar 2019 10:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190326124143.521905652@goodmis.org>
In-Reply-To: <20190326124143.521905652@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Mar 2019 10:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
Message-ID: <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GIT PULL] tracing: Minor fixes for 5.1-rc2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:42 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Please pull the latest trace-v5.1-rc2 tree, which can be found at:

Pulled and pushed out, but for some reason the pr-tracker-bot doesn't
seem to have reacted.

Presumably there's something in your git pull message that means it
doesn't trigger.

And I suspect I know what it is: the patch that your subject line
starts with "[PATCH..]" instead of "[GIT PULL..]"

              Linus
