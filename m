Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298B4C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77A62190F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Vbk/ZCGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbfGWGzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:55:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46006 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfGWGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:55:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so28496268lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KzumU4vf4iQ0yCjcI7GufgOjQcY02wT9BJvKr2yKblQ=;
        b=Vbk/ZCGCgd46r0PMV6Act0cKDWkFQrmxkMtFo5uac99+wBpXse62SUWDz4Ne6diFwz
         L0QzTzgppdR7zXcLyvXiSDpNujZWE0k1aq9gN2WO4XxmEoFsY5W4bVUsrIp9pvLjO2k3
         CLTEyV51LC6anxappuMkxr2ZPcUBxX3V0Nz3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KzumU4vf4iQ0yCjcI7GufgOjQcY02wT9BJvKr2yKblQ=;
        b=Rioe3z5BbWiJ9cti0Hnto2x4ingWwhLFkVzQ7ai3HCxQEjRf3OotT5OvZ31lYsA6dU
         hfN7rVgn37IhLIk2XH7vCx0LGZPG21hpgqesxqTkaLMj04GZ/5Jvuvqfbs1eYGcNCTE2
         1hLg/nYsoHO1fPgwtR3Dk0ULdLB0bsFPxNJfD/Oj3UvuyQINfx4GvGgDhaT22YXtD0yE
         Deu/594bqoZ3tHTAigOeCdm8F/Ul83q2AzSE8ZMx7r4ZfcJtC5YzXMCIgcUgQI+2O3lm
         rf/oJAY9HlntpPu9C3D4G9c0RTEl8XaVoBTMBeJtEzb2KtXJvyGuyFe4f67vHnnpwsFR
         moCg==
X-Gm-Message-State: APjAAAVfCAeQ2bza3nbCK8OETbDiPXVeJAV4Pt620FN4F+4/4aZXIXOh
        riUsfzfZVStMLiTYdoJTG2A=
X-Google-Smtp-Source: APXvYqyDaJthJ33Ha+KAczukiJNzPASPUSTjhru/qheXBb5PobVEd4ScWLMZpVSNtJfe5mX7IhkxfQ==
X-Received: by 2002:a19:4349:: with SMTP id m9mr33666196lfj.64.1563864933047;
        Mon, 22 Jul 2019 23:55:33 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u18sm6288295lfe.65.2019.07.22.23.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:55:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
Date:   Tue, 23 Jul 2019 08:55:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 02.38, Joe Perches wrote:
> Several uses of strlcpy and strscpy have had defects because the
> last argument of each function is misused or typoed.
> 
> Add macro mechanisms to avoid this defect.
> 
> stracpy (copy a string to a string array) must have a string
> array as the first argument (to) and uses sizeof(to) as the
> size.
> 
> These mechanisms verify that the to argument is an array of
> char or other compatible types

yes

like u8 or unsigned char.

no. "unsigned char" aka u8, "signed char" aka s8 and plain char are not
__builtin_types_compatible_p to one another.

> A BUILD_BUG is emitted when the type of to is not compatible.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  include/linux/string.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..f80b0973f0e5 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -35,6 +35,47 @@ ssize_t strscpy(char *, const char *, size_t);
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
>  
> +/**
> + * stracpy - Copy a C-string into an array of char
> + * @to: Where to copy the string, must be an array of char and not a pointer
> + * @from: String to copy, may be a pointer or const char array
> + *
> + * Helper for strscpy.
> + * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination.
> + *
> + * Returns:
> + * * The number of characters copied (not including the trailing %NUL)
> + * * -E2BIG if @to is a zero size array.

Well, yes, but more importantly and generally: -E2BIG if the copy
including %NUL didn't fit. [The zero size array thing could be made into
a build bug for these stra* variants if one thinks that might actually
occur in real code.]

> + */
> +#define stracpy(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\

ARRAY_SIZE should ensure to is indeed an array, but it doesn't hurt to
spell the second condition

  BUILD_BUG_ON(!__same_type(typeof(to), char[]))

(the gcc docs explicitly mention that "The type 'int[]' and 'int[5]' are
compatible.) - just in case that line gets copy-pasted somewhere that
doesn't have another must-be-array check nearby.

You should use a more "unique" identifier than "size". from could be
some expression that refers to such a variable from the surrounding scope.

Rasmus
