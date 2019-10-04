Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4145C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38120659
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCAFtarz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbfJDOpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:45:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbfJDOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570200302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Scxxm9mMdh6m+WuyLezM+86ttbsoWsD/VPmaWFjpaq8=;
        b=cCAFtarzIYJ0bTLenR+K+k4BZPyNNNcMdvaQ0Jalr1quuH5H7e2E+KOhNLtwq7kMKYqNgx
        kEz9hXoz9JAMTX8+y3wAxpykEMUUrOC30siwqoH9IAC1pypJEBvMXGAVfDR9WiUmLZqHry
        F72BW8fXl602J7M90AxBW7oVuDC6GvQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-CO-nh5t6M3Cnbs4twatciA-1; Fri, 04 Oct 2019 10:44:58 -0400
Received: by mail-io1-f70.google.com with SMTP id t11so12253407ioc.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M1gxmM/uPdsRdZwv1pytfxIDTxlUEqqas35fhdgrUzY=;
        b=P6QFRggZ8MJVw9WuAibtWHRdWea25fICkVVFp/XfbgRTsP4dICLdInaAEPZdb8d/wQ
         C2agYB5IAs9WNixAfECf1dSJEZUofx+pftTPXiSHaBZcmFBOaZxAjxoHcJHq/tTx0976
         TF4xETvj2ReuSxFGi4t4RshL0ASRvZttWhk2WfuCwMX8h9ZqpFjnmAdPlpObu2WjGT7B
         DWCJ4q53D4nQUbE/eoTypq1mCDUafXNa4pScHp8ED7M6E38/gONk1R2yFyi2PjpM1m0U
         38wJjjOkpjSMqmgrI3BcBjLycYkkwwib1u3u6H5siZZ0lJe58OnPqgU0959vWpTtnsir
         xgzA==
X-Gm-Message-State: APjAAAVLvMdeSK63R1Z5bSXQv96hAuOE2MVH82Aqv2KC/sul60o6dXzs
        HsG/h8ykbkqXMx+ipEvr0B/XoHQUQyabWGpsLHQwOPf++H97z8jk5tiMb14suXuJmdOiehWZL7e
        6KwhL/aDdXMKY3EB5rmZnTGuT
X-Received: by 2002:a92:d986:: with SMTP id r6mr16324912iln.261.1570200298048;
        Fri, 04 Oct 2019 07:44:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynU8aLzc2L67grr965+sq19xtkA7gFXzQ8d9Jf5gcnim9HQjGR07NJPTXodyn3I4hYKLuLnA==
X-Received: by 2002:a92:d986:: with SMTP id r6mr16324881iln.261.1570200297720;
        Fri, 04 Oct 2019 07:44:57 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.82.15])
        by smtp.gmail.com with ESMTPSA id h62sm3860021ild.78.2019.10.04.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 07:44:56 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
 <20191004094014.72a990ee@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <761c5baf-598d-c2da-bd3e-2a669bf16b50@redhat.com>
Date:   Fri, 4 Oct 2019 16:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004094014.72a990ee@gandalf.local.home>
Content-Language: en-US
X-MC-Unique: CO-nh5t6M3Cnbs4twatciA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 15:40, Steven Rostedt wrote:
> On Fri, 4 Oct 2019 10:10:47 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
>=20
>> [ In addition ]
>>
>> Currently, ftrace_rec entries are ordered inside the group of functions,=
 but
>> "groups of function" are not ordered. So, the current int3 handler does =
a (*):
>>
>> for_each_group_of_functions:
>> =09check if the ip is in the range    ----> n by the number of groups.
>> =09=09do a bsearch.=09=09   ----> log(n) by the numbers of entry
>> =09=09=09=09=09         in the group.
>>
>> If, instead, it uses an ordered vector, the complexity would be log(n) b=
y the
>> total number of entries, which is better. So, how bad is the idea of:
> BTW, I'm currently rewriting the grouping of the vectors, in order to
> shrink the size of each dyn_ftrace_rec (as we discussed at Kernel
> Recipes). I can make the groups all sorted in doing so, thus we can
> load the sorted if that's needed, without doing anything special.
>=20

Good! if you do they sorted and store the amount of entries in a variable, =
we
can have things done for a future "optimized" version.

-- Daniel

