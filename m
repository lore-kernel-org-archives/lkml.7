Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D220323697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567517374;
	bh=NLqCL4CDXLU3XgXKCj95PxujHWeCjp562H7YUcMntWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cB4UePEAD2Pg+y1slx+NjCQRv0kn1vFotxtlPIMiUwhKT9ad7iZLva1AmJooq9Z+I
	 ebVCJTrlBknWK4UakesHzq3GuAeqf8JNeIx7bmQd28C52lE2Fvz1wCx0MGhYmuwTO7
	 Oy1LLWQ3ZZpUmPEnugWXpgJfkcH/9ehgSJwrPD8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfICN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfICN3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:29:33 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498CA23402;
        Tue,  3 Sep 2019 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567517372;
        bh=NLqCL4CDXLU3XgXKCj95PxujHWeCjp562H7YUcMntWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qaXN86v6cIyTWdnvtaZOQQfBuuLThLlMRA/EJyQNgmyoLCjT/75zE/M4mRQeArqAE
         q4YgAkDS6yIyQVA1WxKIVB7rtdCigj9Sz0V6NzXh5PlLXZooECitbVO6sWthzskktB
         K+ItPCsbY4BLi25J8cwa71OUpyPJxZShfeyXk83Q=
Received: by mail-lf1-f44.google.com with SMTP id r134so12000449lff.12;
        Tue, 03 Sep 2019 06:29:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXceZ1F0VtCGnv9s3brmXuw2bEDDN7WCQ0LhshmWuK9GoK3nIy0
        07jSwK7TNhywRrFEtPhPHXfCyUK6Y2dMkQXBWdw=
X-Google-Smtp-Source: APXvYqxqbuDcNwZVBZKdEn/yqco/nPvJHxybzLgeR8t1/wyDoTImujg8oF2KZNPIWeHPuUNFUp5BwgTKED9vOoaznqs=
X-Received: by 2002:ac2:41c2:: with SMTP id d2mr6978921lfi.24.1567517370489;
 Tue, 03 Sep 2019 06:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190902150336.3600-1-krzk@kernel.org> <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
 <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
 <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
 <CAJKOXPcjF9nERQxDdSVBLsfc2V_M1_BPZ6iM6EXvEx4tdr3rDQ@mail.gmail.com> <CAL_Jsq+1NEcmvrKPp9N=07CbxT3ZUsViXk7GGb1v0NzsxvWEdg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1NEcmvrKPp9N=07CbxT3ZUsViXk7GGb1v0NzsxvWEdg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Sep 2019 15:29:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcGWuW7HP-_kj_OjpPyHtj9gr36bpVUeT5VF2V9wTZY9Q@mail.gmail.com>
Message-ID: <CAJKOXPcGWuW7HP-_kj_OjpPyHtj9gr36bpVUeT5VF2V9wTZY9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 at 15:12, Rob Herring <robh+dt@kernel.org> wrote:
> > arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: syscon-reboot:
> > {'regmap': [[9]], 'mask': [[1]], '$nodename': ['syscon-reboot'],
> > 'value': [[1]], 'offset': [[1024]], 'compatible': ['syscon-reboot']}
> > is valid under each of {'required': ['mask']}, {'required': ['value',
> > 'mask']}, {'required': ['value']}
>
> Ahh, right. 'anyOf' is what we want:
>
> anyOf:
>   - required: [ value ]
>   - required: [ mask ]

This triggers meta-schema error:

  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
Traceback (most recent call last):
  File "/home/kozik/.local/lib/python3.5/site-packages/dtschema/lib.py",
line 429, in process_schema
    DTValidator.check_schema(schema)
  File "/home/kozik/.local/lib/python3.5/site-packages/dtschema/lib.py",
line 575, in check_schema
    raise jsonschema.SchemaError.create_from(error)
jsonschema.exceptions.SchemaError: Additional properties are not
allowed ('anyOf' was unexpected)

Failed validating 'additionalProperties' in metaschema['allOf'][0]:
    {'$id': 'http://devicetree.org/meta-schemas/base.yaml#',
     '$schema': 'http://json-schema.org/draft-07/schema#',
     'additionalProperties': False,
     'allOf': [{'$ref': 'http://json-schema.org/draft-07/schema#'}],
     'description': 'Metaschema for devicetree binding documentation',
     'properties': {'$id': {'pattern':
'http://devicetree.org/schemas/.*\\.yaml#'},
                    '$schema': {'enum':
['http://devicetree.org/meta-schemas/core.yaml#',

'http://devicetree.org/meta-schemas/base.yaml#']},
                    'additionalProperties': {'type': 'boolean'},
                    'allOf': {'items': {'propertyNames': {'enum': ['$ref',
                                                                   'if',
                                                                   'then',
                                                                   'else']}}},
                    'definitions': True,
                    'dependencies': True,
                    'description': True,
                    'else': True,
                    'examples': {'items': {'type': 'string'},
                                 'type': 'array'},
                    'if': True,
                    'maintainers': {'items': {'format': 'email',
                                              'type': 'string'},
                                    'type': 'array'},
                    'oneOf': True,
                    'patternProperties': True,
                    'properties': True,
                    'required': True,
                    'select': {'allOf': [{'$ref':
'http://json-schema.org/draft-07/schema#'},
                                         {'oneOf': [{'properties':
{'properties': True,

'required': True},
                                                     'type': 'object'},
                                                    {'type': 'boolean'}]}]},
                    'then': True,
                    'title': {'maxLength': 100},
                    'unevaluatedProperties': {'type': 'boolean'}},
     'required': ['$id', '$schema', 'title', 'maintainers']}

Best regards,
Krzysztof
