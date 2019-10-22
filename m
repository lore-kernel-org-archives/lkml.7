Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6394ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C1B2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571742358;
	bh=dwIMSlnuYx3Xbr72RF9B+7TOlYhW4NUL37tzRmG6lCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EgVNOlvSyrB2wteovi+AuV/fbrLz2LpLmQsJ1nnsnPmAMXcqSCN9xf99TqQSlKZB3
	 9RBBLHy2CyrkMtQX6OWirpD2tU5pBGvQxPZ5hjCNpfxGuzXVD8zwR3o9rOqOSUs0le
	 e+4UC+AXI3oeBdEhJNRWB82FaBzX0foUFLUdc9L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfJVLFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbfJVLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:05:43 -0400
Received: from linux-8ccs (ip5f5ade81.dynamic.kabel-deutschland.de [95.90.222.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DA12184C;
        Tue, 22 Oct 2019 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571742342;
        bh=dwIMSlnuYx3Xbr72RF9B+7TOlYhW4NUL37tzRmG6lCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=15osuNyRo14dz2IxnQRPk3dvXs1YvmzcoxOAjG8I3ef/cPX8TMT3vwhy0SIFUtjUi
         kVEHW34OBv6ocaAcwdrNTx6ooIvNVpBjBb5Sav1vvDQPFWObuM4mhHi9iDh9sqBJJm
         G0PJlBfCcI0EGsWgOmltSaEL6CIWzYgZkM+Ax/UE=
Date:   Tue, 22 Oct 2019 13:05:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] scripts/nsdeps: escape '/' for module source files
Message-ID: <20191022110533.GA16208@linux-8ccs>
References: <20191021145137.31672-1-jeyu@kernel.org>
 <51d0f654a1d94c7d90eb56ee8eac7209@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <51d0f654a1d94c7d90eb56ee8eac7209@AcuMS.aculab.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ David Laight [21/10/19 16:14 +0000]:
>From Jessica Yu
>> Sent: 21 October 2019 15:52
>> When doing an out of tree build with O=, the nsdeps script constructs
>> the absolute pathname of the module source file so that it can insert
>> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
>> contains an unescaped path to the source tree, which, when used in a sed
>> substitution, makes sed complain:
>>
>> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
>> sed: -e expression #1, char 12: unknown option to `s'
>>
>> The sed substitution command 's' ends prematurely with the forward
>> slashes in the pathname, and sed errors out when it encounters the 'h',
>> which is an invalid sed substitution option. So use bash in-variable
>> substitution to escape all forward slashes for sed.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>  scripts/nsdeps | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index 3754dac13b31..79f96e596a0b 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -33,7 +33,7 @@ generate_deps() {
>>  	if [ ! -f "$ns_deps_file" ]; then return; fi
>>  	local mod_source_files=`cat $mod_file | sed -n 1p                      \
>>  					      | sed -e 's/\.o/\.c/g'           \
>> -					      | sed "s/[^ ]* */${srctree}\/&/g"`
>> +					      | sed "s/[^ ]* */${srctree//\//\\\/}\/&/g"`
>
>Rather than adding a bashism - which might bight back later, just change the
>command to use (say) ; instead of / as the separator.
>I think that makes it:
>	sed "s;[^ ]* *;${srctree}/&;g
>
>	David

Thanks David! Matthias suggested this as well and so I've sent a v3.

