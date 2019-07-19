Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A6C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BB42084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rqn8qj5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfGSRpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:45:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38246 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSRpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:45:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so31550892ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNAALzOvftMNuIGo/Hvnr5KO7EC6ztWulyg3Fk0l3Jc=;
        b=Rqn8qj5UNOnX2Y6C0MDJSj5U5Mhxhe2BkesN3t+5CZ8lNabC9OfSlASlombTRYGKw0
         PsA3hhRhtpCkTCYx9AnAl6incofbfMtRC3tiJFGUdDY3hBZZueevEYihxD7cTRM1lX9+
         bOLoPpS5O2j+adBG8Lfn4PtZCybxckT9UulJ9BADJYKHYLIWL1OYVtPizkyz5BI7NQA/
         umnRkXI+6k9nVuNlayZaNJDfuI7rWGC1emyS9rsd7yIYUVTWsltG5AlSY7xGx86ApAcA
         a0JnylRDt9S21K4pc/Om1SVH6idBbCtMTuKFGuIQ9/+WDybKTC42AWzZhUdBK0cuShAn
         pD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNAALzOvftMNuIGo/Hvnr5KO7EC6ztWulyg3Fk0l3Jc=;
        b=Gu9v1USM4jG0uHiB/rq5Rp3bT0ffN3UXjNdVlbVjnKE+Gv2SmyGnDQ96OjZgTZaV4l
         priPFQcwvrXW45n5edK1/VhmRLFOz/Cb2zEGsFxYuklZLTI1NzOoq0EHgWVAzjoriX+2
         AeqClEnEbaKfVtpVMmtkDMstcVqShwIx9qumXNxny0mkcitzAGTYu7cxxFpHrs7woeQp
         LTzorfYcO9G/qh6rcolzIvKLt+I4QUa3UBJaGZxXOPnFHbL7tcdiNf7/jE0agO1dokfo
         3w5qKQeusMwhZDL9SKbU6ah6BY7OdNt7psCnJGHuyJTUUPN2KQTVxKH1rj9CB7EBkO5G
         lhkw==
X-Gm-Message-State: APjAAAVBPEy0zwpJvZYToReONAkOsv6gHcGbA/+5NoMYahdhU/LT2INh
        3V6GyVQkon9GF3sLna/rBgH+Bj+DCsRPYBi7V83ZZA==
X-Google-Smtp-Source: APXvYqxJ8gLqkFkjRUVHt7emv8EI40XfhprvCj9W+0xBDGMiIP5V3bdoOZobK4eON5c/d0Mh7vVaar/f+htzBegmJkE=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr27952332ljj.151.1563558306044;
 Fri, 19 Jul 2019 10:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR11MB1757F23147F85B59BCF1628BAFC90@MWHPR11MB1757.namprd11.prod.outlook.com>
 <20190718.163207.289099133864098969.davem@davemloft.net>
In-Reply-To: <20190718.163207.289099133864098969.davem@davemloft.net>
From:   Catherine Sullivan <csully@google.com>
Date:   Fri, 19 Jul 2019 10:44:54 -0700
Message-ID: <CAH_-1qwjgoi7Yve0s1NS1oEKXmxu3V5SPZMzy-Wwux-gM0Pf+Q@mail.gmail.com>
Subject: Re: [PATCH] gve: replace kfree with kvfree
To:     David Miller <davem@davemloft.net>
Cc:     chuhongyuan@outlook.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 4:32 PM David Miller <davem@davemloft.net> wrote:
>
> From: Chuhong YUAN <chuhongyuan@outlook.com>
> Date: Wed, 17 Jul 2019 00:59:02 +0000
>
> > Variables allocated by kvzalloc should not be freed by kfree.
> > Because they may be allocated by vmalloc.
> > So we replace kfree with kvfree here.
> >
> > Signed-off-by: Chuhong Yuan <chuhongyuan@outlook.com>
>
> Applied, thanks Chuhong.
>
> GVE maintainers, you are upstream now and have to stay on top of review
> of changes like this.  Otherwise I'll just review it myself and apply
> it unless I find problems, and that may not be what you want :)

Will do, thanks for the review. And thanks for the fix Chuhong.
