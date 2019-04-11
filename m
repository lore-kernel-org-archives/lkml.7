Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B65CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6D22133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554980463;
	bh=B8ZqnajDq1P4x6a+ekymSwZWU9OatLgBYElZxCiJgBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ne8oHEPlH/N1u0MvoVcpf4sDT8+r3Xl//G9SPl4Putv3xZBm6f3InJsepBlqdRcpo
	 9MHgF4UpRtUE+B8lJBWexfQ4vDR7gokm+WE4EobciHahAExguaA6nk/tFg/NVX8osB
	 P+QmIyAu79ELzBSubCWYng7WqU9eGsAVdiOTnung=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKLBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:01:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:01:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so6144839wml.4;
        Thu, 11 Apr 2019 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A4hA9gnL7qolBPYfhqSuC0XGf0x7JKmJY3jB14vG6lw=;
        b=PflIfYCkxHvKGhcQNYCZgGszujEUZESfdpYK6Qt9SdB2+jebGdiFAB3Ijr1RC2Hvru
         dImJMBzMcKTYLzXDEU86WemJ50e/UPaDdGdPCcpL0eCY6rE7c5ZG5VluLTE5Z07oQobv
         WTYT8kQve8ET0IklV6d8n02/7kt2Rjj6BxbFGi9mzYIo5U96YytQrsyfGKziLGzRVsdT
         bloNQ6dnwFlFvpA/Y5bEBrCE36jLRfbKfCv7DaxdNANPV2MTgZ/5XxoByGBIpGt6YJik
         0cr7QbqxJAJW28uaUjRSDvxHobV4R+i+69OebNkIWLN+AaXmSs9nO8uo/iTWWvsWr4wl
         iq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4hA9gnL7qolBPYfhqSuC0XGf0x7JKmJY3jB14vG6lw=;
        b=qkj/tuLWF0itzDmWPHWJfrSLdhe/x2fCH2yZEvLGUP8NH1ahtc9P5eZHgcRbLlLwQ4
         AFdwluas7JWD6jMBXNdDL+m79SI+8OMEcj61rVohwxfFFYfgT4dRwdGJk6WGPGuymCyM
         9DzzrmjTHosxLirApv2LOooPg0sjT4xUKSDYycC0EYIloo7MWTYYN1EyaeIw7CLsJwnJ
         rQoD+9UoZ5FKbdQKLFZTlZeV9uy6Jn4kxdJ66U57LI3JfujzCLvABOcXfz/5+f+IhuPX
         NNo2AUPeEW46/AE/PNntkQf6lrAG3noQFNmWYLxvBnBqVJPJtHar16XsRwqAl8YVvWo/
         TKxg==
X-Gm-Message-State: APjAAAW/t0O1Sw/IT5BVE7SeXA7PR4Otpm87ls4UxCtBgljgKfyaKgFt
        9aprGC8Tiux/9r46pgN/TMM=
X-Google-Smtp-Source: APXvYqzw+BK0RsC1mBmTfX0ILA4a85Zl2LeITaZYPhjTkR9/YqtwOK25pKRv1NYpWZP4rVFvNzOwfQ==
X-Received: by 2002:a7b:c92f:: with SMTP id h15mr6160834wml.115.1554980459962;
        Thu, 11 Apr 2019 04:00:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l23sm4228106wmj.10.2019.04.11.04.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 04:00:58 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:00:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190411110056.GA3894@gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <20190410105833.GA116161@gmail.com>
 <20190410122834.GB21169@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410122834.GB21169@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> Anyway, please take a look at the diff below and let me know if you're
> happy with it. The original commit is currently at the bottom of my mmiowb
> tree, so I'll probably put this on top as an extra commit with your
> Reported-by.

Sure - and the changes look good to me:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
