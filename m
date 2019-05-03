Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856CEC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56529206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenSNmyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfECIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:31:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44251 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:31:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so2020776lfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2ylaX4prU4y+pJMH/9/AjUxzWLSop/aCDuaVRH32I0=;
        b=fenSNmyAj8ADxOqyLIXpSSgKSa18U27vLWgPFOcTBPX3r1oVH/L5+X7iKMGOav5uC7
         L7bNwKgzA8UuBq2OxXMFqWzjntIcIRlUgwx4iTgUVD2S9JbOyQlnwO06rXTW95YWvJGl
         j3xNn+GCJReS8E1zTpEzk+gOjOUjTHsjJal/KK8+doqYfnBNAF9LG7UtGIq+NHK+e1SR
         9V/k0feRtMS6QhkvHmFjSydmOg6TYZ0XFkAqZ7ZDXt7TcX5hM3kXuWUTZekjyBzK4E4D
         0N3J6vwqXCQAWdlssO5SLt3FhAvt7j6kJlBy3oynVH/CFt04n+ncij+gVW/iwrpUqUFv
         ydaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2ylaX4prU4y+pJMH/9/AjUxzWLSop/aCDuaVRH32I0=;
        b=RYz9zq+cL5AF83G/ZnGqNPoi/pPV7/MS/GkYvq66um8wYRE1YGrsmyi0iXA7MHrVee
         8gzNVOWnbA/gMPZl9XYOEVliQcV5VVofz+BCcEk3Lhztv/eix4z1XwtwUPdC2wcKSSzW
         SM/y7oOEmIVL5Mgr9z6pi4irHpd3p7zajW0LlvS/95T51LNCFDsfOPf/QFWgqQnLbVRQ
         SsZbJbMkzgjsesSkrHfoLOsUdFO/ENBViIKgX7TTRCzxH7dTlXYANXNsf5pWpMW7kkqn
         NEhbNth3RGFHLs6cZ3pcqd/gbTZBtUj6a4yP1KLvFXRB6amACjbDyNp+o9uIab84enJW
         8x5w==
X-Gm-Message-State: APjAAAVRC2C1rv7Ll4jFOUr70GTaUeQ7DqY5D10elJMJW18EV6Z4GVwF
        ghYfWHQkuIoQZoKCam/Q7S8=
X-Google-Smtp-Source: APXvYqz/F601TjsizceYi3h6zVYbfffsDkGISMMCQWPUJFYk/Fyck/6BZ5MgKXOLvl1t6oS9lr/1NQ==
X-Received: by 2002:ac2:50ca:: with SMTP id h10mr4468043lfm.31.1556872310606;
        Fri, 03 May 2019 01:31:50 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id v23sm270042ljk.14.2019.05.03.01.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 01:31:49 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 530F04603F4; Fri,  3 May 2019 11:31:49 +0300 (MSK)
Date:   Fri, 3 May 2019 11:31:49 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <norov.maillist@gmail.com>
Subject: Re: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Message-ID: <20190503083149.GH2488@uranus.lan>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
 <20190502210922.GF2488@uranus.lan>
 <CAL1p7m6eC3-99oFEyp0F1xn7qN4Vx+s-kHQXh14cMUWoVFqbWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1p7m6eC3-99oFEyp0F1xn7qN4Vx+s-kHQXh14cMUWoVFqbWw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:46:08PM -0400, Joel Savitz wrote:
> > Won't be possible to use put_user here? Something like
> >
> > static int prctl_get_tasksize(unsigned long __user *uaddr)
> > {
> >         return put_user(TASK_SIZE, uaddr) ? -EFAULT : 0;
> > }
> 
> What would be the benefit of using put_user() over copy_to_user() in
> this context?

It is a common pattern to use put_user with native types, where
copy_to_user more biased for composed types transfer.
