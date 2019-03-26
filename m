Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDDAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A80020866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcjFcCTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfCZR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:56:10 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:54765 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:56:10 -0400
Received: by mail-it1-f171.google.com with SMTP id w18so21060701itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EokdJk0jdZKei/GtsxXIf6RBVdRcX2HGb5Qo163dW3M=;
        b=jcjFcCTaZET+wKT/MDTuz6ncFZ3fkmub6+/VZ/WG7LrK+6i7VTOmqfgNpHyAvFDhC7
         tqbjHdQsj2z624p76D+mDzFThq1lA7GZK0HolHAhSejSS9+TTEypxqqL8TZSDEp3srNs
         pbB1S88P3GRrVtmQyv3jqUWQm5ipA4Wy/8VN2lCozdFqqOQzJELYKILUrjwEFQjKmQ5s
         L9L/di2sly2TvkyqWvOWszP/5zoKRf6NS0L9c/PmGqRcdX30jEZSNPxMU3288C/Iw+oX
         lGyOts9KJa5OzGvDMQP1IxXsbMkKgGcLOhSebXmiPf0JO5zENwYdjxg3egx1uThO24BF
         eSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EokdJk0jdZKei/GtsxXIf6RBVdRcX2HGb5Qo163dW3M=;
        b=c4w5uG/959IiBjUQfSip4neby+lxrNg5d0xRaCK3cukYMfOCcYLRCn+7ha/E1F2ZSK
         1L+NbKwk/5a1auDFr5fJ7C4cA/KRK5bb3bK30RbQUCiYXsVUs8nbuUz/47vmuR1CCOYR
         TRAP1G8H5mU5W1Z9XU6eIHah4uP1dmrytdJLfN5DcsnXoXmPvIDeN31JLZZuh6jlKBVF
         czuoOEOhy+bJ++D1rzhFiefUj082bgl4tiY5tdND2qfnmuGvbPcws0aFpGAkmWdp9n97
         9HaLJEJbhgfVEv0VNIQtB75DeTW/m1Q/OiJCNb40mhMpBvpGJFLUe2wdi3WlE6/zjnJ3
         dDKA==
X-Gm-Message-State: APjAAAW5zlSASVqMTNUBaB9owZPDAJEvRCL8eB16MMjkyvhz1ZV+Dry+
        0GLH2MNE2BE/Zh2Jkj3T4ksuaf6lmt3nY1Ftk272HQ==
X-Google-Smtp-Source: APXvYqwJnIpGVvUVKCJ9LB7LUZJPMbQErQPRWQbI3XFxVfOtGDzS8cACAci4GAkd5fydOZvoCAUJ6i1mLEWFmgU1CJ8=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr104352iti.161.1553622968800;
 Tue, 26 Mar 2019 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
 <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
 <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca> <2006016.NXIvICiRTL@x2>
 <1553614157.4115.17.camel@linux.ibm.com> <20190326161409.3wej7hcwnqalf4or@madcap2.tricolour.ca>
 <20190326174252.irqrldtcy5bwho6k@madcap2.tricolour.ca>
In-Reply-To: <20190326174252.irqrldtcy5bwho6k@madcap2.tricolour.ca>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 26 Mar 2019 10:55:57 -0700
Message-ID: <CACdnJusGS94GTVkGO1xsczdksBVEf39A7z-H36tWNDo5xwobqQ@mail.gmail.com>
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record
 to syscall event
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, omosnace@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:43 AM Richard Guy Briggs <rgb@redhat.com> wrote:

> Ok, what I typed above wasn't quite what I intended...  This is what I
> meant:
>
>         audit_log_format(ab, "xattr=");
>         audit_log_untrustedstring(ab, ".");
>
> But, I'll just move the normal case above the "." locking detection and
> log all cases the same way.

Sounds good to me.
