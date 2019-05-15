Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BECC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7C22082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0ZXSezWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEOVqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:46:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37198 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfEOVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:46:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so1572702qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=CxvbzMmpFZKCZQrQpPZlOyX2uSYjnK1WHB0Mu1JYc0M=;
        b=0ZXSezWejE0cywXdKuYQCQ11X7PsPCAx37NYYV2CfX9/p5x7b9UB57iSnNK1b3xDpg
         aOMWrEYIeVccVgnt9YFUzD5ro2w+lrKcXnxzJy2EmPc5AWTgAM5LuGmK0NK6XPPL9rXv
         Ae4dCSIPn/Bufb3raRFMcAjqsHa6YM1Are8URdyjB7PuglCJraDNoag82GWBSpwx9sgp
         nU0gB58HZ5KJ5BOwYPW8LEwtqvldpOZ26jFM+37wkBlBRePAkCVLqAZznd36k+tKM070
         YipiZDGA0ut4o/yy0/PS0Rbe/9357kAo0+6x2cRpff1dM8YFTlgkfaOoNIY4cRs542eH
         vK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=CxvbzMmpFZKCZQrQpPZlOyX2uSYjnK1WHB0Mu1JYc0M=;
        b=fGL7uRy7mTi9nkxIvnZeqy7MCT//TLPWKVuzoDE2qDSsFYtyGscKYAsCglr04kdtXG
         ENsQGHzLK/zCQZsUSYG2Mih9oOdMUjQxejf2a+wU1g+BS9PkjI2LLQ6XELzp+uKAtYBJ
         xhclVvk+MBcAl39hK7i591jnZ1/w3wPJrQHRw3YGR/SV3dlMZyYiQbf0oLn0eOOZuG04
         wrtJeXOL4Q50bsisNl8qRZex7VN2UiVEQ07eno1kD0JknMwQCirmtNrzB9b3LH3TmOV/
         pshvPtIzyPH2heA0VnVPY+76m6QPTPm4YRvLoOxplHR2z/Mx5UIuIjbzxZn7h0j+1UEC
         EW6A==
X-Gm-Message-State: APjAAAUK6h/4DNXOSwkedpHom0pSjm/4G2Ps75GF021zid8Lz0aQpuze
        fOh+8dlGOzfgFr2mPhxWET82YA==
X-Google-Smtp-Source: APXvYqw8CWhpLfaEMuaBeEoKwDffLp9ZpXjQCPPNhUlQ6xYspR4xI7Yyd1yexfhCdgMhGZvdpTJnAw==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr21766241qti.284.1557956762150;
        Wed, 15 May 2019 14:46:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p8sm2228633qta.24.2019.05.15.14.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:46:02 -0700 (PDT)
Date:   Wed, 15 May 2019 14:45:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Krzesimir Nowak <krzesimir@kinvolk.io>
Cc:     bpf@vger.kernel.org, iago@kinvolk.io, alban@kinvolk.io,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester
 could not run a program
Message-ID: <20190515144537.57f559e7@cakuba.netronome.com>
In-Reply-To: <20190515134731.12611-3-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
        <20190515134731.12611-3-krzesimir@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 15:47:27 +0200, Krzesimir Nowak wrote:
> This prints a message when the error is about program type being not
> supported by the test runner or because of permissions problem. This
> is to see if the program we expected to run was actually executed.
> 
> The messages are open-coded because strerror(ENOTSUPP) returns
> "Unknown error 524".
> 
> Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index ccd896b98cac..bf0da03f593b 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
>  				tmp, &size_tmp, &retval, NULL);
>  	if (unpriv)
>  		set_admin(false);
> -	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
> -		printf("Unexpected bpf_prog_test_run error ");
> -		return err;
> +	if (err) {
> +		switch (errno) {
> +		case 524/*ENOTSUPP*/:
> +			printf("Did not run the program (not supported) ");
> +			return 0;
> +		case EPERM:
> +			printf("Did not run the program (no permission) ");
> +			return 0;

Perhaps use strerror(errno)?

> +		default:
> +			printf("Unexpected bpf_prog_test_run error ");
> +			return err;
> +		}
>  	}
> -	if (!err && retval != expected_val &&
> +	if (retval != expected_val &&
>  	    expected_val != POINTER_VALUE) {
>  		printf("FAIL retval %d != %d ", retval, expected_val);
>  		return 1;

