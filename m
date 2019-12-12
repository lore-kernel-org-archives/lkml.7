Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC493C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C68F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDtYfaI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfLLWcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:32:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfLLWcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576189941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcJp5d02ffhslABjm0JRL5WxPWI1YxxsBS3tQ0tjUug=;
        b=XDtYfaI74YB1jl9e6Ye8GjQN4x86M+iUMiKEw0sG9mkgX/UDJIEMfeb6VZcJunMMW6T0tl
        gQGfop+00QPxlxipicXXiaFiEDcjgjuhWkcTXJIpyDWkhAa51Vq7NJ1kPtZbPNuWmoI2ev
        HxQAL7iCm17MxW+3+tU+zE0RIakzeSI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-jsWde_DON_Ce3oDUDmjC4A-1; Thu, 12 Dec 2019 17:32:18 -0500
X-MC-Unique: jsWde_DON_Ce3oDUDmjC4A-1
Received: by mail-qt1-f198.google.com with SMTP id x8so496452qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcJp5d02ffhslABjm0JRL5WxPWI1YxxsBS3tQ0tjUug=;
        b=pCP0DNuhWIXdp6yJQ0hQ+ejtvMeRIdloUrB+acJT8g4BdM16CXsaOCasrHGCvrZHgk
         iP8pNpxxlsUAslfzBb6cR7dK5901x4vFL7GScEOUXwWQNRanen2ZotbGSK/yEIdOa7v3
         BOJwnADbnh0ZGfi6nrG2BPzb8jYwUpSDvnHNLjkIFw63KT1tWoU52707D/VQi0C5Bea/
         3XvW8tjDLYmZtyHg/FSzsnV43gzVk4b8bVAwfio8aSrumcnyi5n2zJDCVrH+V1C63JIe
         RTdgDL2g1kYPIDG+kNFI+j6Vv5uBWKG8Ne+8x15b50I17wP9jI9B0ySD2ZQVFnPCnHkY
         8Xrg==
X-Gm-Message-State: APjAAAVC6QEeOR2Sk++RK1KTPM9qXrz4cgL+Xq8HlG6AuNClhyW5YoZn
        3qZoNl49mPYTBe2W673fmoXQo08DIdu4n7i5uUFcio7Kt8QjIYY8y54ejOL3mFgHAvhClJwk+IL
        eUh8Q0zRtLfpXx/L7KzQq+i+3
X-Received: by 2002:a0c:acc2:: with SMTP id n2mr10517807qvc.225.1576189937882;
        Thu, 12 Dec 2019 14:32:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPTmOy4ajO0DxlZVi3iwrbQ6XXtLuFR20j6ai74yyPPLB1q/GpEEJj/ZsbDHyyFh1kYXNvbA==
X-Received: by 2002:a0c:acc2:: with SMTP id n2mr10517773qvc.225.1576189937490;
        Thu, 12 Dec 2019 14:32:17 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id a24sm2155877qkl.82.2019.12.12.14.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:32:16 -0800 (PST)
Subject: Re: [PATCH] vfs: Handle file systems without ->parse_params better
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
References: <20191212213604.19525-1-labbott@redhat.com>
 <20191212214724.GL4203@ZenIV.linux.org.uk>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <27e4379a-baae-4dbb-1fcf-c4a92fcde341@redhat.com>
Date:   Thu, 12 Dec 2019 17:32:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212214724.GL4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 4:47 PM, Al Viro wrote:
> On Thu, Dec 12, 2019 at 04:36:04PM -0500, Laura Abbott wrote:
>> @@ -141,14 +191,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>>   		 */
>>   		return ret;
>>   
>> -	if (fc->ops->parse_param) {
>> -		ret = fc->ops->parse_param(fc, param);
>> -		if (ret != -ENOPARAM)
>> -			return ret;
>> -	}
>> +	parse_param = fc->ops->parse_param;
>> +	if (!parse_param)
>> +		parse_param = fs_generic_parse_param;
>> +
>> +	ret = parse_param(fc, param);
>> +	if (ret != -ENOPARAM)
>> +		return ret;
>>   
>> -	/* If the filesystem doesn't take any arguments, give it the
>> -	 * default handling of source.
>> +	/*
>> +	 * File systems may have a ->parse_param function but rely on
>> +	 * the top level to parse the source function. File systems
>> +	 * may have their own source parsing though so this needs
>> +	 * to come after the call to parse_param above.
>>   	 */
>>   	if (strcmp(param->key, "source") == 0) {
>>   		if (param->type != fs_value_is_string)
>> -- 
>> 2.21.0
> 
> No.  Please, get rid of the boilerplate.  About 80% of that thing
> is an absolutely pointless dance around "but we need that to call
> fs_parse()".  We do *NOT* need to call fs_parse() here.  We do
> not need a struct fs_parameter_description instance.  We do not
> need struct fs_parameter_spec instances.  We do not need a magical
> global constant.  And I'm not entirely convinced that we need
> to make fs_generic_parse_param() default - filesystems that
> want this behaviour can easily ask for it.  A sane default is
> to reject any bogus options.
> 

Well the existing behavior was to silently ignore options by
default so this was an attempt to preserve that behavior for
everything rather than keep hitting user visible bugs. I'd
rather not have to deal this this for each file system.

> I would call it ignore_unknowns_parse_param(), while we are at it.
> 


