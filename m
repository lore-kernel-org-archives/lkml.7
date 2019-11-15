Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1E5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FBF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwazyEje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKORCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:02:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:02:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so6975996pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/2Ncf9XpoSg49t52uYQ/CLx1FaV03Rgw+InMqXFWtNU=;
        b=JwazyEjer+frxvk77JvsvZxqIm+ScQuw0ZBmLzoG1ANpnvFgoZgKGc+LyjxUHWoKDv
         6X3ucoraCBNHhmlS/aW2YaXzxsqI7luGSYOkBXqHQA7S6aRER7BkFYKXi6Qng9Yw1/zO
         0lKfJqL0h2MhiWB3dlqXNfuncuYQKBjKi0ErfT5z4nlCOuVTEAqwyUplv4H4lZFV9VV6
         dorFwFNcIkbBh63cxexV51omwXlYFYK7KgMXm/dmY8fHf+Omu06ecVmLxBHOW/H+yAze
         lEZMMaxeutW2wZTkZ4kVzdnvK16sL7qkddAp59U0pWdEE6xFqNm9CNnDp67F49k6owQ9
         WBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2Ncf9XpoSg49t52uYQ/CLx1FaV03Rgw+InMqXFWtNU=;
        b=mCA3hUf9oIXX5K35XPNOY6r8MyUSGUF1B2UOlgnCx1eQW7E4w+6YKKk/Z/v2WNGq4P
         RS7xcVS8lsQSQGDTlzGb8Di1b1iQd6od/n6q+jmNPsrXu7garOG3A74joTGSJZp1/urs
         CeMMHGL82WyoOeA268O/U7tMbf+DI9Fr1oK9aD5ywNzrlklZq+yiDSoZ0xmpwhwV0ywq
         GUIwdcCXLJPZFZF8CwURTcWgVHHy0B6AJ3hthtSP4feLg98i9WmFx02TNEuCenmLP93O
         G9wZLX4M/NAOu3cIAoo1bEXiFglch5D7MEftChfoTwrtqYp0wR3hOxhmIZutf4o5YDmP
         BxPQ==
X-Gm-Message-State: APjAAAURP0ENxLZp2C/Z5KffyWShBtlnEuYLdFIeXvLtKdcpkyWxCBko
        n52//c/+NEE9TRhR+lxDMyGvzpTO4dY=
X-Google-Smtp-Source: APXvYqxecLtEIaF8B7DlihJJBRWfY9bsRPGKxYINxOPpg+c6+TPhNzo75D9+KcdxnrWvnVcaB91H1g==
X-Received: by 2002:aa7:918e:: with SMTP id x14mr17805599pfa.12.1573837344909;
        Fri, 15 Nov 2019 09:02:24 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r22sm13014264pfg.54.2019.11.15.09.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 09:02:24 -0800 (PST)
Subject: Re: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
From:   Dmitry Safonov <0x7f454c46@gmail.com>
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191115123621.142252-1-areber@redhat.com>
 <fada5995-7fcc-7ca8-0933-4d0f52deef6e@gmail.com>
Message-ID: <446bbd86-1cbb-fcec-92b2-69a9f996c78e@gmail.com>
Date:   Fri, 15 Nov 2019 17:02:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fada5995-7fcc-7ca8-0933-4d0f52deef6e@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 4:54 PM, Dmitry Safonov wrote:

> [..]
>> +	size_t set_tid_size;
>> +	__aligned_u64 set_tid_size;
> 
> [..]
>> +		.set_tid_size	= args.set_tid_size,
> 
> Is sizeof(size_t) == 32 on native 32-bit platforms?
> Maybe `args.set_tid_size` should be checked?

Nevermind, I missed that
+	if (unlikely(args.set_tid_size > MAX_PID_NS_LEVEL))
+		return -EINVAL;

is checked for `args' - it should be good enough.

Thanks,
          Dmitry
