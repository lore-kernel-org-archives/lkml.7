Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0BCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE6E21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfJUQOi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:14:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48101 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfJUQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:14:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-164-yBUMtxjzPbGpm7yEvcnd1w-1; Mon, 21 Oct 2019 17:14:35 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 21 Oct 2019 17:14:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 21 Oct 2019 17:14:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jessica Yu' <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RE: [PATCH] scripts/nsdeps: escape '/' for module source files
Thread-Topic: [PATCH] scripts/nsdeps: escape '/' for module source files
Thread-Index: AQHViB8egCT4CShepk2NuWs8og91m6dlRBcw
Date:   Mon, 21 Oct 2019 16:14:34 +0000
Message-ID: <51d0f654a1d94c7d90eb56ee8eac7209@AcuMS.aculab.com>
References: <20191021145137.31672-1-jeyu@kernel.org>
In-Reply-To: <20191021145137.31672-1-jeyu@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: yBUMtxjzPbGpm7yEvcnd1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Jessica Yu
> Sent: 21 October 2019 15:52
> When doing an out of tree build with O=, the nsdeps script constructs
> the absolute pathname of the module source file so that it can insert
> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
> contains an unescaped path to the source tree, which, when used in a sed
> substitution, makes sed complain:
> 
> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
> sed: -e expression #1, char 12: unknown option to `s'
> 
> The sed substitution command 's' ends prematurely with the forward
> slashes in the pathname, and sed errors out when it encounters the 'h',
> which is an invalid sed substitution option. So use bash in-variable
> substitution to escape all forward slashes for sed.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 3754dac13b31..79f96e596a0b 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -33,7 +33,7 @@ generate_deps() {
>  	if [ ! -f "$ns_deps_file" ]; then return; fi
>  	local mod_source_files=`cat $mod_file | sed -n 1p                      \
>  					      | sed -e 's/\.o/\.c/g'           \
> -					      | sed "s/[^ ]* */${srctree}\/&/g"`
> +					      | sed "s/[^ ]* */${srctree//\//\\\/}\/&/g"`

Rather than adding a bashism - which might bight back later, just change the
command to use (say) ; instead of / as the separator.
I think that makes it:
	sed "s;[^ ]* *;${srctree}/&;g

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

