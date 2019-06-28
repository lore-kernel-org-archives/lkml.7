Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3A2208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561757004;
	bh=mHbU3WRKgmrt62CPlChU1cXyJ9SixlLXl431+HBkBzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxZTwwnh3hKk+LnrBMzR5tCAFDhEW0QCy+A6zFSOAX6Mz3VuclJY7c1eLDVYwda5u
	 NP6708CwmykXXV5wVtWfA2K+AtKJ+UK7/f5wOgNh3QvngE2DmJfb8Hmv3+cG6+eLZq
	 AQUKiNkLp6E74dFTZgiJCiCW6wSU9FGfWeIlhtCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1VXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:23:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF1VXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hWpmIxaGb4riYKyi+9gRcydxFcohGEpnXR71vncI7fY=; b=Xzfdzgi5yZH0WMyadyXwwsjOwd
        KlRHwr02tn9f6RMP7+l/7yDfFvyXGDJSg3AKT7SF6y6LGhqbtctA30D/ylAMBclwiO5cJSz0sNxda
        eNHsYu3TiXpC/dRq3ElwKQb7hSsUQKZM8YXW3w1S4HbHJxvC5nsfIAsJJr3guviQc8E6FvlYBI763
        NB5o8TtavnxJ97juIWTMvCgVffXCsc1jEFUovXXg3MjnRWJd7F0fmFYvfD1bnrQy+BUUF2W8h+EWb
        JuQojUzpHdAKf+LEaBO3DVV7cKf4hs4+fArTCqjqz5G+W5qt4rWJETvXrXJQ8WqRxRCThGbiKtdYP
        WH5z68pQ==;
Received: from [187.113.3.250] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgyL2-0001VG-KR; Fri, 28 Jun 2019 21:23:21 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgyKz-0002dm-TC; Fri, 28 Jun 2019 18:23:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 1/5] docs: convert markdown documents to ReST
Date:   Fri, 28 Jun 2019 18:23:12 -0300
Message-Id: <7a5734d147788ffb817c8122dbb0ff619a718a71.1561756511.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561756511.git.mchehab+samsung@kernel.org>
References: <cover.1561756511.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation standard is ReST and not markdown.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/writing-schema.md    | 130 ---------------
 Documentation/devicetree/writing-schema.rst   | 153 ++++++++++++++++++
 ...entication.md => ubifs-authentication.rst} |  70 +++++---
 3 files changed, 197 insertions(+), 156 deletions(-)
 delete mode 100644 Documentation/devicetree/writing-schema.md
 create mode 100644 Documentation/devicetree/writing-schema.rst
 rename Documentation/filesystems/{ubifs-authentication.md => ubifs-authentication.rst} (95%)

diff --git a/Documentation/devicetree/writing-schema.md b/Documentation/devicetree/writing-schema.md
deleted file mode 100644
index dc032db36262..000000000000
--- a/Documentation/devicetree/writing-schema.md
+++ /dev/null
@@ -1,130 +0,0 @@
-# Writing DeviceTree Bindings in json-schema
-
-Devicetree bindings are written using json-schema vocabulary. Schema files are
-written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
-considered more human readable and has some advantages such as allowing
-comments (Prefixed with '#').
-
-## Schema Contents
-
-Each schema doc is a structured json-schema which is defined by a set of
-top-level properties. Generally, there is one binding defined per file. The
-top-level json-schema properties used are:
-
-- __$id__ - A json-schema unique identifier string. The string must be a valid
-URI typically containing the binding's filename and path. For DT schema, it must
-begin with "http://devicetree.org/schemas/". The URL is used in constructing
-references to other files specified in schema "$ref" properties. A $ref values
-with a leading '/' will have the hostname prepended. A $ref value a relative
-path or filename only will be prepended with the hostname and path components
-of the current schema file's '$id' value. A URL is used even for local files,
-but there may not actually be files present at those locations.
-
-- __$schema__ - Indicates the meta-schema the schema file adheres to.
-
-- __title__ - A one line description on the contents of the binding schema.
-
-- __maintainers__ - A DT specific property. Contains a list of email address(es)
-for maintainers of this binding.
-
-- __description__ - Optional. A multi-line text block containing any detailed
-information about this binding. It should contain things such as what the block
-or device does, standards the device conforms to, and links to datasheets for
-more information.
-
-- __select__ - Optional. A json-schema used to match nodes for applying the
-schema. By default without 'select', nodes are matched against their possible
-compatible string values or node name. Most bindings should not need select.
-
-- __allOf__ - Optional. A list of other schemas to include. This is used to
-include other schemas the binding conforms to. This may be schemas for a
-particular class of devices such as I2C or SPI controllers.
-
-- __properties__ - A set of sub-schema defining all the DT properties for the
-binding. The exact schema syntax depends on whether properties are known,
-common properties (e.g. 'interrupts') or are binding/vendor specific properties.
-
-  A property can also define a child DT node with child properties defined
-under it.
-
-  For more details on properties sections, see 'Property Schema' section.
-
-- __patternProperties__ - Optional. Similar to 'properties', but names are regex.
-
-- __required__ - A list of DT properties from the 'properties' section that
-must always be present.
-
-- __examples__ - Optional. A list of one or more DTS hunks implementing the
-binding. Note: YAML doesn't allow leading tabs, so spaces must be used instead.
-
-Unless noted otherwise, all properties are required.
-
-## Property Schema
-
-The 'properties' section of the schema contains all the DT properties for a
-binding. Each property contains a set of constraints using json-schema
-vocabulary for that property. The properties schemas are what is used for
-validation of DT files.
-
-For common properties, only additional constraints not covered by the common
-binding schema need to be defined such as how many values are valid or what
-possible values are valid.
-
-Vendor specific properties will typically need more detailed schema. With the
-exception of boolean properties, they should have a reference to a type in
-schemas/types.yaml. A "description" property is always required.
-
-The Devicetree schemas don't exactly match the YAML encoded DT data produced by
-dtc. They are simplified to make them more compact and avoid a bunch of
-boilerplate. The tools process the schema files to produce the final schema for
-validation. There are currently 2 transformations the tools perform.
-
-The default for arrays in json-schema is they are variable sized and allow more
-entries than explicitly defined. This can be restricted by defining 'minItems',
-'maxItems', and 'additionalItems'. However, for DeviceTree Schemas, a fixed
-size is desired in most cases, so these properties are added based on the
-number of entries in an 'items' list.
-
-The YAML Devicetree format also makes all string values an array and scalar
-values a matrix (in order to define groupings) even when only a single value
-is present. Single entries in schemas are fixed up to match this encoding.
-
-## Testing
-
-### Dependencies
-
-The DT schema project must be installed in order to validate the DT schema
-binding documents and validate DTS files using the DT schema. The DT schema
-project can be installed with pip:
-
-`pip3 install git+https://github.com/devicetree-org/dt-schema.git@master`
-
-dtc must also be built with YAML output support enabled. This requires that
-libyaml and its headers be installed on the host system.
-
-### Running checks
-
-The DT schema binding documents must be validated using the meta-schema (the
-schema for the schema) to ensure they are both valid json-schema and valid
-binding schema. All of the DT binding documents can be validated using the
-`dt_binding_check` target:
-
-`make dt_binding_check`
-
-In order to perform validation of DT source files, use the `dtbs_check` target:
-
-`make dtbs_check`
-
-This will first run the `dt_binding_check` which generates the processed schema.
-
-It is also possible to run checks with a single schema file by setting the
-'DT_SCHEMA_FILES' variable to a specific schema file.
-
-`make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/trivial-devices.yaml`
-
-
-## json-schema Resources
-
-[JSON-Schema Specifications](http://json-schema.org/)
-
-[Using JSON Schema Book](http://usingjsonschema.com/)
diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
new file mode 100644
index 000000000000..8f71d1e2ac52
--- /dev/null
+++ b/Documentation/devicetree/writing-schema.rst
@@ -0,0 +1,153 @@
+:orphan:
+
+Writing DeviceTree Bindings in json-schema
+==========================================
+
+Devicetree bindings are written using json-schema vocabulary. Schema files are
+written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
+considered more human readable and has some advantages such as allowing
+comments (Prefixed with '#').
+
+Schema Contents
+---------------
+
+Each schema doc is a structured json-schema which is defined by a set of
+top-level properties. Generally, there is one binding defined per file. The
+top-level json-schema properties used are:
+
+$id
+  A json-schema unique identifier string. The string must be a valid
+  URI typically containing the binding's filename and path. For DT schema, it must
+  begin with "http://devicetree.org/schemas/". The URL is used in constructing
+  references to other files specified in schema "$ref" properties. A $ref values
+  with a leading '/' will have the hostname prepended. A $ref value a relative
+  path or filename only will be prepended with the hostname and path components
+  of the current schema file's '$id' value. A URL is used even for local files,
+  but there may not actually be files present at those locations.
+
+$schema
+  Indicates the meta-schema the schema file adheres to.
+
+title
+  A one line description on the contents of the binding schema.
+
+maintainers
+  A DT specific property. Contains a list of email address(es)
+  for maintainers of this binding.
+
+description
+  Optional. A multi-line text block containing any detailed
+  information about this binding. It should contain things such as what the block
+  or device does, standards the device conforms to, and links to datasheets for
+  more information.
+
+select
+  Optional. A json-schema used to match nodes for applying the
+  schema. By default without 'select', nodes are matched against their possible
+  compatible string values or node name. Most bindings should not need select.
+
+ allOf
+  Optional. A list of other schemas to include. This is used to
+  include other schemas the binding conforms to. This may be schemas for a
+  particular class of devices such as I2C or SPI controllers.
+
+ properties
+  A set of sub-schema defining all the DT properties for the
+  binding. The exact schema syntax depends on whether properties are known,
+  common properties (e.g. 'interrupts') or are binding/vendor specific properties.
+
+A property can also define a child DT node with child properties defined
+under it.
+
+For more details on properties sections, see 'Property Schema' section.
+
+patternProperties
+  Optional. Similar to 'properties', but names are regex.
+
+required
+  A list of DT properties from the 'properties' section that
+  must always be present.
+
+examples
+  Optional. A list of one or more DTS hunks implementing the
+  binding. Note: YAML doesn't allow leading tabs, so spaces must be used instead.
+
+Unless noted otherwise, all properties are required.
+
+Property Schema
+---------------
+
+The 'properties' section of the schema contains all the DT properties for a
+binding. Each property contains a set of constraints using json-schema
+vocabulary for that property. The properties schemas are what is used for
+validation of DT files.
+
+For common properties, only additional constraints not covered by the common
+binding schema need to be defined such as how many values are valid or what
+possible values are valid.
+
+Vendor specific properties will typically need more detailed schema. With the
+exception of boolean properties, they should have a reference to a type in
+schemas/types.yaml. A "description" property is always required.
+
+The Devicetree schemas don't exactly match the YAML encoded DT data produced by
+dtc. They are simplified to make them more compact and avoid a bunch of
+boilerplate. The tools process the schema files to produce the final schema for
+validation. There are currently 2 transformations the tools perform.
+
+The default for arrays in json-schema is they are variable sized and allow more
+entries than explicitly defined. This can be restricted by defining 'minItems',
+'maxItems', and 'additionalItems'. However, for DeviceTree Schemas, a fixed
+size is desired in most cases, so these properties are added based on the
+number of entries in an 'items' list.
+
+The YAML Devicetree format also makes all string values an array and scalar
+values a matrix (in order to define groupings) even when only a single value
+is present. Single entries in schemas are fixed up to match this encoding.
+
+Testing
+-------
+
+Dependencies
+~~~~~~~~~~~~
+
+The DT schema project must be installed in order to validate the DT schema
+binding documents and validate DTS files using the DT schema. The DT schema
+project can be installed with pip::
+
+    pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
+
+dtc must also be built with YAML output support enabled. This requires that
+libyaml and its headers be installed on the host system.
+
+Running checks
+~~~~~~~~~~~~~~
+
+The DT schema binding documents must be validated using the meta-schema (the
+schema for the schema) to ensure they are both valid json-schema and valid
+binding schema. All of the DT binding documents can be validated using the
+``dt_binding_check`` target::
+
+    make dt_binding_check
+
+In order to perform validation of DT source files, use the `dtbs_check` target::
+
+    make dtbs_check
+
+This will first run the `dt_binding_check` which generates the processed schema.
+
+It is also possible to run checks with a single schema file by setting the
+``DT_SCHEMA_FILES`` variable to a specific schema file.
+
+::
+
+    make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/trivial-devices.yaml
+
+
+json-schema Resources
+---------------------
+
+
+`JSON-Schema Specifications <http://json-schema.org/>`_
+
+`Using JSON Schema Book <http://usingjsonschema.com/>`_
diff --git a/Documentation/filesystems/ubifs-authentication.md b/Documentation/filesystems/ubifs-authentication.rst
similarity index 95%
rename from Documentation/filesystems/ubifs-authentication.md
rename to Documentation/filesystems/ubifs-authentication.rst
index 23e698167141..6a9584f6ff46 100644
--- a/Documentation/filesystems/ubifs-authentication.md
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -1,8 +1,11 @@
-% UBIFS Authentication
-% sigma star gmbh
-% 2018
+:orphan:
 
-# Introduction
+.. UBIFS Authentication
+.. sigma star gmbh
+.. 2018
+
+Introduction
+============
 
 UBIFS utilizes the fscrypt framework to provide confidentiality for file
 contents and file names. This prevents attacks where an attacker is able to
@@ -33,7 +36,8 @@ existing features like key derivation can be utilized. It should however also
 be possible to use UBIFS authentication without using encryption.
 
 
-## MTD, UBI & UBIFS
+MTD, UBI & UBIFS
+----------------
 
 On Linux, the MTD (Memory Technology Devices) subsystem provides a uniform
 interface to access raw flash devices. One of the more prominent subsystems that
@@ -47,7 +51,7 @@ UBIFS is a filesystem for raw flash which operates on top of UBI. Thus, wear
 leveling and some flash specifics are left to UBI, while UBIFS focuses on
 scalability, performance and recoverability.
 
-
+::
 
 	+------------+ +*******+ +-----------+ +-----+
 	|            | * UBIFS * | UBI-BLOCK | | ... |
@@ -84,7 +88,8 @@ persisted onto the flash directly. More details on UBIFS can also be found in
 [UBIFS-WP].
 
 
-### UBIFS Index & Tree Node Cache
+UBIFS Index & Tree Node Cache
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Basic on-flash UBIFS entities are called *nodes*. UBIFS knows different types
 of nodes. Eg. data nodes (`struct ubifs_data_node`) which store chunks of file
@@ -118,17 +123,18 @@ on-flash filesystem structures like the index. On every commit, the TNC nodes
 marked as dirty are written to the flash to update the persisted index.
 
 
-### Journal
+Journal
+~~~~~~~
 
 To avoid wearing out the flash, the index is only persisted (*commited*) when
-certain conditions are met (eg. `fsync(2)`). The journal is used to record
+certain conditions are met (eg. ``fsync(2)``). The journal is used to record
 any changes (in form of inode nodes, data nodes etc.) between commits
 of the index. During mount, the journal is read from the flash and replayed
 onto the TNC (which will be created on-demand from the on-flash index).
 
 UBIFS reserves a bunch of LEBs just for the journal called *log area*. The
 amount of log area LEBs is configured on filesystem creation (using
-`mkfs.ubifs`) and stored in the superblock node. The log area contains only
+``mkfs.ubifs``) and stored in the superblock node. The log area contains only
 two types of nodes: *reference nodes* and *commit start nodes*. A commit start
 node is written whenever an index commit is performed. Reference nodes are
 written on every journal update. Each reference node points to the position of
@@ -152,6 +158,7 @@ done for the last referenced LEB of the journal. Only this can become corrupt
 because of a power cut. If the recovery fails, UBIFS will not mount. An error
 for every other LEB will directly cause UBIFS to fail the mount operation.
 
+::
 
        | ----    LOG AREA     ---- | ----------    MAIN AREA    ------------ |
 
@@ -172,10 +179,11 @@ for every other LEB will directly cause UBIFS to fail the mount operation.
                           containing their buds
 
 
-### LEB Property Tree/Table
+LEB Property Tree/Table
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The LEB property tree is used to store per-LEB information. This includes the
-LEB type and amount of free and *dirty* (old, obsolete content) space [1] on
+LEB type and amount of free and *dirty* (old, obsolete content) space [1]_ on
 the LEB. The type is important, because UBIFS never mixes index nodes with data
 nodes on a single LEB and thus each LEB has a specific purpose. This again is
 useful for free space calculations. See [UBIFS-WP] for more details.
@@ -185,19 +193,21 @@ index. Due to its smaller size it is always written as one chunk on every
 commit. Thus, saving the LPT is an atomic operation.
 
 
-[1] Since LEBs can only be appended and never overwritten, there is a
-difference between free space ie. the remaining space left on the LEB to be
-written to without erasing it and previously written content that is obsolete
-but can't be overwritten without erasing the full LEB.
+.. [1] Since LEBs can only be appended and never overwritten, there is a
+   difference between free space ie. the remaining space left on the LEB to be
+   written to without erasing it and previously written content that is obsolete
+   but can't be overwritten without erasing the full LEB.
 
 
-# UBIFS Authentication
+UBIFS Authentication
+====================
 
 This chapter introduces UBIFS authentication which enables UBIFS to verify
 the authenticity and integrity of metadata and file contents stored on flash.
 
 
-## Threat Model
+Threat Model
+------------
 
 UBIFS authentication enables detection of offline data modification. While it
 does not prevent it, it enables (trusted) code to check the integrity and
@@ -224,7 +234,8 @@ Additional measures like secure boot and trusted boot have to be taken to
 ensure that only trusted code is executed on a device.
 
 
-## Authentication
+Authentication
+--------------
 
 To be able to fully trust data read from flash, all UBIFS data structures
 stored on flash are authenticated. That is:
@@ -236,7 +247,8 @@ stored on flash are authenticated. That is:
 - The LPT which stores UBI LEB metadata which UBIFS uses for free space accounting
 
 
-### Index Authentication
+Index Authentication
+~~~~~~~~~~~~~~~~~~~~
 
 Through UBIFS' concept of a wandering tree, it already takes care of only
 updating and persisting changed parts from leaf node up to the root node
@@ -260,6 +272,7 @@ include a hash. All other types of nodes will remain unchanged. This reduces
 the storage overhead which is precious for users of UBIFS (ie. embedded
 devices).
 
+::
 
                              +---------------+
                              |  Master Node  |
@@ -303,7 +316,8 @@ hashes to index nodes does not change this since each hash will be persisted
 atomically together with its respective node.
 
 
-### Journal Authentication
+Journal Authentication
+~~~~~~~~~~~~~~~~~~~~~~
 
 The journal is authenticated too. Since the journal is continuously written
 it is necessary to also add authentication information frequently to the
@@ -316,7 +330,7 @@ of the hash chain. That way a journal can be authenticated up to the last
 authentication node. The tail of the journal which may not have a authentication
 node cannot be authenticated and is skipped during journal replay.
 
-We get this picture for journal authentication:
+We get this picture for journal authentication::
 
     ,,,,,,,,
     ,......,...........................................
@@ -352,7 +366,8 @@ the superblock struct. The superblock node is stored in LEB 0 and is only
 modified on feature flag or similar changes, but never on file changes.
 
 
-### LPT Authentication
+LPT Authentication
+~~~~~~~~~~~~~~~~~~
 
 The location of the LPT root node on the flash is stored in the UBIFS master
 node. Since the LPT is written and read atomically on every commit, there is
@@ -363,7 +378,8 @@ be verified by verifying the authenticity of the master node and comparing the
 LTP hash stored there with the hash computed from the read on-flash LPT.
 
 
-## Key Management
+Key Management
+--------------
 
 For simplicity, UBIFS authentication uses a single key to compute the HMACs
 of superblock, master, commit start and reference nodes. This key has to be
@@ -399,7 +415,8 @@ approach is similar to the approach proposed for fscrypt encryption policy v2
 [FSCRYPT-POLICY2].
 
 
-# Future Extensions
+Future Extensions
+=================
 
 In certain cases where a vendor wants to provide an authenticated filesystem
 image to customers, it should be possible to do so without sharing the secret
@@ -411,7 +428,8 @@ to the way the IMA/EVM subsystem deals with such situations. The HMAC key
 will then have to be provided beforehand in the normal way.
 
 
-# References
+References
+==========
 
 [CRYPTSETUP2]        http://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
 
-- 
2.21.0

