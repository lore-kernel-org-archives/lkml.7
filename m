Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D21021874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlp8ZXU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfHFVoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:44:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34519 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHFVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:44:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id q128so31392324ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj5yWDm+drkTcWobF+B+SfSeu4cUAiftcsjQzbtvZZY=;
        b=Nlp8ZXU+iRYXz+eicM7sucfWByTxLZlSUEMe+5TCM0kxhttbD8YZQUoFTWZunYxXmp
         I/e5wOSzrUceMTBbGN1OQmuTBK1yQQWZYghpIASRwkYcOdsdzIT9crfPdYhBnUOREvPd
         jbHe+qXPQnE98IT0H4cclpWE0x1lzeLnHP/d53ETi4wtdMc6UD+cr0bMoVgG5ZnL6ynp
         Fij+6I0DxihfeV8S+h3SanKCuoWcbO8PLk5idomALLwVkakjOytRnXyvWQg8K/XIM3Ch
         P5Z7BOxrkVbdR9/hmjTFkfKlXcpwDTHqy8XIvJnUEflwRu/ysG1KZ4aGfqrBSjTy5JBh
         5vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj5yWDm+drkTcWobF+B+SfSeu4cUAiftcsjQzbtvZZY=;
        b=b3HcNW0cTr+OnJpTcV4iBDTuMBXPXkInN9Y7FXpHJPjmo+XQzXU0kzuNb7qoAVMYxa
         RrH/AMx0mimAEiQH+z6mHLQCFoFUxv2Ami91of5W/2uKA7aqZ9GLvos3XhB+Ktb0UuOg
         1tm1jZnMLFIqkszU0E6qAv8eipxhw5aNyjz9iSiZedncxgtjNDqxkrMeK40KtoZk7qLX
         UNHwa1x/bX1L/WnK9cFMAKTTiKhWGnAiJl420W1hGWeww5094ItmVB6cXPSN0C1aTXJN
         73krDnw+Xb0zF9GkBxOJFNjrendCnThrhRZv/lROtnWjKYiSAjmhLDS2NPkzng1IHSgW
         NKIg==
X-Gm-Message-State: APjAAAX1lfDAiRLX1r9aS6RgObM0L9emCi4SX6psVJM5LLMoWqFp3bNu
        yVo+oI2bi/BoJ6fIzZwenrEBkmBILpi+rXB9Plk=
X-Google-Smtp-Source: APXvYqx98csDDMKW2OnhxGRVIMUeXsN2yQsTDDvbcC6C7CoChvt3D8EsbYnNKwz0+TgDOJvVzaUc0cUgy9d3/SVfJCM=
X-Received: by 2002:a81:5c0a:: with SMTP id q10mr3990074ywb.474.1565127842511;
 Tue, 06 Aug 2019 14:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com> <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org> <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Tue, 6 Aug 2019 22:43:25 +0100
Message-ID: <CAAMvbhEPcOw_kOVANSTUwPbNe2ebGL65ZEtyqdFhnwNMZ=NuVw@mail.gmail.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 at 02:09, Suren Baghdasaryan <surenb@google.com> wrote:
>
> 80% of the last 10 seconds spent in full stall would definitely be a
> problem. If the system was already low on memory (which it probably
> is, or we would not be reclaiming so hard and registering such a big
> stall) then oom-killer would probably kill something before 8 seconds
> are passed.

There are other things to consider also.
I can reproduce these types of symptoms and memory pressure is 100%
NOT the cause. (top showing 4GB of a 16GB system in use)
The cause as I see it is disk pressure and the lack of multiple queues
for disk IO requests.
For example, one process can hog 100% of the disk, without other
applications even being able to write just one sector.
We need a way for the linux kernel to better multiplex access to the
disk. Adding QOS, allowing interactive processes to interrupt long
background disk IO tasks.
If we could balance disk access across each active process, the user,
on their desktop, would think the system was more responsive.

Kind Regards

James
