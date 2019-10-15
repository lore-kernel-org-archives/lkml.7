Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE12ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF90121848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="U+go+LWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfJOMRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:17:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44298 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJOMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:17:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so19955849ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUJTabcY6j71b4GEzT6XKyo8OBw2INdC4r2qptOidxI=;
        b=U+go+LWtGXKusitb49F19WlIVIDHj7gSpDxev5jxUs+tgODOSSljUeAI0z+9yRTyC4
         rq04lPaNiYgxNTccdFQenABGPqWjBdycG5N1Z1BSlIy2NeaNR//k1BvoXbUhY43l838m
         b6I82UTLrEw6GlvXjKx/KmhWJY23aBSqyVq/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUJTabcY6j71b4GEzT6XKyo8OBw2INdC4r2qptOidxI=;
        b=Uug2ie7Snsnlg8t7fdlAazoGJe3SpBVUVg2xLvM/lyEjgSycQgxRPw5QDA5KFSVZvt
         Miu0OTB+YJcHV5hqdjik+q4NfpJIuvknekmNyDcVKals7YoUtp0bydboFC094Qp9obaw
         0o5bs0J4w6uARdYRxsrkVG7uslX+9/bkUf3IHDsXzXaiNZwJMjH0uJzAXLwFZF/4wV5v
         h6aE5uz6NJdY82a/m2qFSntmQJx7QHi2BHVdf/jOjcaGyHEK5GMyKVbyI0mkZ4f6sxK0
         2KWK6Acp9q07TFw0Uk4IVbqqs5Ij7Zmi42TtTP11tyXPmWXxfQPsk6ViF9O+fNAReAer
         Pu+g==
X-Gm-Message-State: APjAAAWvkykIFrjQaaafcxlGWNTs9xHLw4QZsfiaveME6/QlrwlI+o90
        2QltHuWgAMmblw02v6kqLLAxADaC1XY/tPWM
X-Google-Smtp-Source: APXvYqxJv/tHWvf7G4r3UK0GcZfBDev93FD7sy9ciNDJgJRGLVALObpk0pPQfbLqW5qg4me40tsapg==
X-Received: by 2002:a2e:8e87:: with SMTP id z7mr19558852ljk.207.1571141866797;
        Tue, 15 Oct 2019 05:17:46 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3sm4890962lfc.31.2019.10.15.05.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 05:17:45 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] printf: add support for printing symbolic error
 names
To:     Petr Mladek <pmladek@suse.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191011133617.9963-2-linux@rasmusvillemoes.dk>
 <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <226edb75-b954-cbb4-4ba5-6529a725fe43@rasmusvillemoes.dk>
Date:   Tue, 15 Oct 2019 14:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014130247.rag2g7qz54uiw54z@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 15.02, Petr Mladek wrote:
> On Fri 2019-10-11 15:36:17, Rasmus Villemoes wrote:
>> It has been suggested several times to extend vsnprintf() to be able
>> to convert the numeric value of ENOSPC to print "ENOSPC". This
>> implements that as a %p extension: With %pe, one can do
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I like the patch. There are only two rather cosmetic things.
> 
>> diff --git a/lib/errname.c b/lib/errname.c
>> new file mode 100644
>> index 000000000000..30d3bab99477
>> --- /dev/null
>> +++ b/lib/errname.c
>> +const char *errname(int err)
>> +{
>> +	bool pos = err > 0;
>> +	const char *name = __errname(err > 0 ? err : -err);
>> +
>> +	return name ? name + pos : NULL;
> 
> This made me to check C standard. It seems that "true" really has
> to be "1".
> 
> But I think that I am not the only one who is not sure.
> I would prefer to make it less tricky and use, for example:
> 
> 	const char *name = __errname(err > 0 ? err : -err);
> 	if (!name)
> 		return NULL;
> 
> 	return err > 0 ? name + 1 : name;

I didn't even stop to think that using the value of a comparison
operator/bool in arithmetic might be the littlest bit surprising for C
programmers. But your suggestion isn't terrible, so go ahead and write
it that way. And can I get you to fix the missing "-" in the MIPS
"EDQUOT" special case while you're at it?

>> +static void __init
>> +errptr(void)
>> +{
>> +	char buf[PLAIN_BUF_SIZE];
>> +
>> +	test("-1234", "%pe", ERR_PTR(-1234));
>> +
>> +	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
>> +	BUILD_BUG_ON(IS_ERR(PTR));
>> +	snprintf(buf, sizeof(buf), "(%p)", PTR);
>> +	test(buf, "(%pe)", PTR);
> 
> There is a small race. "(____ptrval____)" is used for %p before
> random numbers are initialized. The switch is done via workqueue
> work, see enable_ptr_key_workfn(). It means that it can be done
> in parallel.

I know.

> I doubt that anyone would ever hit the race. But it could be very confusing
> and hard to debug.

I thought about it and decided not to care, as long as the errptr test
comes after the hashing test, because if the hashing is not initialized
then one gets a warning. I also considered setting a flag in that case
and then skipping the errptr hash test, but again, decided that the
warning would be enough.

> I would replace it with:

> 	test_hashed("%pe", PTR);

Sure, that will repeat the warning, but it doesn't seem to prevent a
false positive: Between plain_hash_to_buffer emitting the warning (and
returning 0) and the caller test_hashed() then performing the test()
against the buffer contents, the hash can become initialized and thus
change how %p[e] gets formatted. But ok, perhaps it is cleaner to reuse
test_hashed and avoid the local buffer in errptr. So yeah, I suppose
this on top is fine:

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 4fa0ccf58420..030daeb4fe21 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -596,14 +596,11 @@ flags(void)
 static void __init
 errptr(void)
 {
-       char buf[PLAIN_BUF_SIZE];
-
        test("-1234", "%pe", ERR_PTR(-1234));

        /* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
        BUILD_BUG_ON(IS_ERR(PTR));
-       snprintf(buf, sizeof(buf), "(%p)", PTR);
-       test(buf, "(%pe)", PTR);
+       test_hashed("%pe", PTR);

 #ifdef CONFIG_SYMBOLIC_ERRNAME
        test("(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));



> If would like to have the two things fixed. I am not sure if you want
> to send one more revision. Or I could also change it by follow
> up patch when pushing.

I prefer you to fold in both changes instead of an extra patch, and if
you can't, I'll send a new revision.

Rasmus
